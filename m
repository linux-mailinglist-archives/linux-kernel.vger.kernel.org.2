Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03903967C5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhEaSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:23:29 -0400
Received: from granite.fifsource.com ([173.255.216.206]:55790 "EHLO
        granite.fifsource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhEaSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:23:26 -0400
Received: from ceramic.fifi.org (107-142-44-66.lightspeed.sntcca.sbcglobal.net [107.142.44.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by granite.fifsource.com (Postfix) with ESMTPSA id A5D9C4060;
        Mon, 31 May 2021 11:21:46 -0700 (PDT)
Message-ID: <24bfdd74524752b21922350e4a3650ff446175da.camel@fifi.org>
Subject: Re: [Intel-gfx] Bug: 5.12.5 - list_add double add at
 __i915_gem_object_make_shrinkable+0xa6/0xe0
From:   Philippe Troin <phil@fifi.org>
To:     Matthew Auld <matthew.william.auld@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Mon, 31 May 2021 11:21:46 -0700
In-Reply-To: <CAM0jSHOWwgPRWkSN22r6T_rkiVcdhYwN34vkzp0q_icgDqT52Q@mail.gmail.com>
References: <4d84b06ee9e8dad88ff101de5e7b78b9b09cfee3.camel@fifi.org>
         <20210524075121.1949-1-hdanton@sina.com>
         <CAM0jSHOWwgPRWkSN22r6T_rkiVcdhYwN34vkzp0q_icgDqT52Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-24 at 14:38 +0100, Matthew Auld wrote:
> On Mon, 24 May 2021 at 13:05, Hillf Danton <hdanton@sina.com> wrote:
> > 
> > On Sun, 23 May 2021 12:47:34 -0700 Philippe Troin wrote:
> > > Found the following bug on a FUJITSU LIFEBOOK S6520.
> > > 
> > > The kernel crash happens when selecting a user from the gdm login
> > > screen right after boot.
> > > The same hardware has no problems with 5.11.21.
> 
> The trace looks similar to something that was fixed in 8777d17b68dc
> ("drm/i915/gem: Pin the L-shape quirked object as unshrinkable") which
> should now be in drm-tip. Could you try that? Otherwise could you
> please file a new bug report at
> https://gitlab.freedesktop.org/drm/intel/?

I verified that drm-tip is working as of
d6d3a2a996af7a82e567e96a19410ac9d7246794.
This issue was tracked in the Fedora bugzilla at
https://bugzilla.redhat.com/show_bug.cgi?id=1963782

Thanks.
Phil.

