Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8339F6AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhFHMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232627AbhFHMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E94760FDA;
        Tue,  8 Jun 2021 12:30:53 +0000 (UTC)
Date:   Tue, 8 Jun 2021 14:30:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     containers@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: device namespaces
Message-ID: <20210608123050.zde5lwmovjr4yhiy@wittgenstein>
References: <ca7520c9-d260-6c87-43b9-f9be24ded50c@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca7520c9-d260-6c87-43b9-f9be24ded50c@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:38:16AM +0200, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> I'm going to implement device namespaces, where containers can get an
> entirely different view of the devices in the machine (usually just a
> specific subset, but possibly additional virtual devices).
> 
> For start I'd like to add a simple mapping of dev maj/min (leaving aside
> sysfs, udev, etc). An important requirement for me is that the parent ns
> can choose to delegate devices from those it full access too (child
> namespaces can do the same to their childs), and the assignment can
> change (for simplicity ignoring the case of removing devices that are
> already opened by some process - haven't decided yet whether they should
> be forcefully closed or whether keeping them open is a valid use case).
> 
> The big question for me now is how exactly to do the table maintenance
> from userland. We already have entries in /proc/<pid>/ns/*. I'm thinking
> about using them as command channel, like this:
> 
> * new child namespaces are created with empty mapping
> * mapping manipulation is done by just writing commands to the ns file
> * access is only granted if the writing process itself is in the
>  parent's device ns and has CAP_SYS_ADMIN (or maybe their could be some
>  admin user for the ns ? or the 'root' of the corresponding user_ns ?)
> * if the caller has some restrictions on some particular device, these
>  are automatically added (eg. if you're restricted to readonly, you
>  can't give rw to the child ns).
> 
> Is this a good way to go ? Or what would be a better one ?

Ccing Greg. Without adressing specific problems, I should warn you that
this idea is not new and the plan is unlikely to go anywhere. Especially
not without support from Greg.

Also note that I have done work to make it possible to do sufficient
device management in containers. There's a longer series associated with
this but the gist is 692ec06d7c92 ("netns: send uevent messages") where
you can forward uevents to containers. I spoke about this at Plumbers in
2018 or so too. For example, LXD makes use of this. When you hotplug a
device into a container LXD will forward the generated uevents to the
container making it possible for the container to manage those devices.
That's fully under control of userspace and means we don't need to
burden the kernel with this.
