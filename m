Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2495C3CC83E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhGRJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 05:04:45 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21314 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhGRJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 05:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626598895; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=no8t3Q/xQT2MtkrM8auQd508gyzFYHKVzf5OxkiDBkdsyuOon/MLmzcgthRwEhjDz5eGUMkNjm3ag3HAGrA/OXpkYODNw7t8wsiStDykTvu/0v9JuWEZc6MB/PKXdERZnUX1TOLBV7WB/LC1eU4ETmnmPaISAMBRNnRIbEMtwH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626598895; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2wt/14A1pbZkAsPR8s1nN21cj4iIR0IrgJ5NsyPUWKI=; 
        b=mfRLlzmNU2Uw5ifLLMgMnAoPm6MMD+JhDRgM2wwQZ3URRbit9DQKFxdjgAp2pOh+YcJlzR4KkS/6GA1jCxpfX/vMcoumIxnPcNVBgeHfZThHX5BMHoei/UBF7btYorrnj7l+p+s5onNT1tYFp+ZVlsXesPZMPlBii+bjkOVA3hI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626598895;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=2wt/14A1pbZkAsPR8s1nN21cj4iIR0IrgJ5NsyPUWKI=;
        b=vi6tkpXBNdff45SnZnZAN6MDzNz81TmFdQkJyRVFUSLRhUxSe+m5egpzHYsa7xsp
        JLln7RAJYrxe9xicLTh18dnM2+YYflfYaT+Jr8D45c53njIqW4yiWxaytqIoSNVJmnv
        EZ4EvR6ZAztcuRCY0JA1DDJfRMxIQCc+PXD9cRnA=
Received: from anirudhrb.com (106.51.111.185 [106.51.111.185]) by mx.zohomail.com
        with SMTPS id 1626598890186242.15286515869423; Sun, 18 Jul 2021 02:01:30 -0700 (PDT)
Date:   Sun, 18 Jul 2021 14:31:23 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com,
        mail@anirudhrb.com
Subject: Re: [PATCH] firmware_loader: Fix use-after-free Read in
 firmware_loading_store
Message-ID: <YPPt42dw47tluE4V@anirudhrb.com>
References: <20210708031321.50800-1-skhan@linuxfoundation.org>
 <20210709091721.1869-1-hdanton@sina.com>
 <d851dd11-1b4f-4ed2-bad2-0c267e3d6021@linuxfoundation.org>
 <3eb42554-c054-6e46-54ce-b9f637b72751@linuxfoundation.org>
 <20210715222817.tjsotu7fuhwz37ki@garbanzo>
 <d17eeb0f-a46e-2515-43a6-36c16002928a@linuxfoundation.org>
 <20210715232105.am4wsxfclj2ufjdw@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715232105.am4wsxfclj2ufjdw@garbanzo>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:21:05PM -0700, Luis Chamberlain wrote:
> On Thu, Jul 15, 2021 at 04:46:24PM -0600, Shuah Khan wrote:
> > On 7/15/21 4:28 PM, Luis Chamberlain wrote:
> > > On Fri, Jul 09, 2021 at 10:38:12AM -0600, Shuah Khan wrote:
> > > > However I am seeing the following over and over again in the
> > > > log - hence I think it is safer to check the aborted status
> > > > in __fw_load_abort().
> > > > 
> > > > ? __list_del_entry_valid+0xe0/0xf0
> > > > [  348.604808][T12994]  __list_del_entry_valid+0xe0/0xf0
> > > > [  348.610020][T12994]  firmware_loading_store+0x141/0x650
> > > > [  348.615761][T12994]  ? firmware_data_write+0x4e0/0x4e0
> > > > [  348.621064][T12994]  ? sysfs_file_ops+0x1c0/0x1c0
> > > > [  348.625921][T12994]  dev_attr_store+0x50/0x80
> > > > 
> > > > Also the fallback logic takes actions based on errors as in
> > > > fw_load_sysfs_fallback() that returns -EAGAIN which would
> > > > trigger request_firmware() again.
> > > > 
> > > > Based on all of this I think this fix is needed, if only I can
> > > > test for sure.
> > > 
> > > Shuah, curious if you had read this patch from Anirudh Rayabharam
> > > and my response to that v4 patch iteration?
> > > 
> > > https://lkml.kernel.org/r/20210518155921.4181-1-mail@anirudhrb.com
> > > 
> > 
> > Yes. I realized I am trying to fix the same problem we have been
> > discussing. :) Sorry for the noise.
> 
> No worries, and thanks again for you help!
> 
> > Ignore my patch. I will follow the thread.
> 
> OK ! I think all we need is just Anirudh to split his patch to
> remove the -EAGAIN return value in a separate patch as a first step,
> documenting in the commmit log that:
> 
> The only motivation on her part with using -EAGAIN on commit
> 0542ad88fbdd81bb ("firmware loader: Fix _request_firmware_load()
> return val for fw load abort") was to distinguish the error from
> -ENOMEM, and so there is no real reason in keeping it. Keeping

Are you sure about this? As per Shuah's explanation [1], it sounds to
me like certain media drivers explicitly check for -EAGAIN to retry
the firmware load. Shuah, is my understanding correct?

[1]: https://lore.kernel.org/lkml/04b5bb2f-edf7-5b43-585a-3267d83bd8c3@linuxfoundation.org/

> -ETIMEDOUT is much telling of what the reason for a failure is,
> so just use that.
> 
> Then his second patch would be simplified without the -EAGAIN
> condition.
> 
> All I asked was to confirm that the -ETIMEDOUT was indeed propagated.

Yes, -ETIMEDOUT is indeed propagated by fw_sysfs_wait_timeout.

> 
> Anirudh, sorry for the trouble, but can I ask you for a v5 with two
> patches as described above?

Sure, I will do that. 

	- Anirudh.

> 
>   Luis
