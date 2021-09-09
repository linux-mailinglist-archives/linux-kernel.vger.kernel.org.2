Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A108C4044AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350483AbhIIFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:07:51 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:50210 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229995AbhIIFHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:07:50 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E87AD180A955C;
        Thu,  9 Sep 2021 05:06:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 3AF24D1517;
        Thu,  9 Sep 2021 05:06:40 +0000 (UTC)
Message-ID: <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Lang Yu <lang.yu@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908120723.3920701-1-lang.yu@amd.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Wed, 08 Sep 2021 22:05:53 -0700
MIME-Version: 1.0
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3AF24D1517
X-Stat-Signature: jzpnwiawxmqzgtf17trntyp73iijhdnd
X-Spam-Status: No, score=-0.75
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/bydSvJtepf+1nVGPcfZ+8hxW/H9gzO4Y=
X-HE-Tag: 1631164000-150190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
> The key purpose of sysfs_emit and sysfs_emit_at is to
> ensure that no overrun is done. Make them more equivalent
> with scnprintf.

I can't think of a single reason to do this.
sysfs_emit and sysfs_emit_at are specific to sysfs.

Use of these functions outside of sysfs is not desired or supported.



