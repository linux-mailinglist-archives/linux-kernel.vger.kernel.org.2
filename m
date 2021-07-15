Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B363CAF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGOXYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:24:05 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:38822 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGOXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:24:04 -0400
Received: by mail-pl1-f181.google.com with SMTP id u3so4312485plf.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rx0vajRDvLl3jbu5aD4BedKIzqXQpNLEH+SuRJBL1XI=;
        b=hOSQQkuUlqPSOmGqUZbdNBgoBGG7dyUHJtASFKkWl5KuvSclFe2OniF2sMZ+8ZdHNZ
         1KkcpcGOAFqjdR9Mh0ogbXqYNw1eI8bW562NgyvgiyYULNXQjC1IeHuUCtH4wSbqs86K
         YAeSp3T8JdEIpsUL0msoYcmLSEMWtbj/gGJXmd68fPnJEaOXRToXwptpsYI4eRAlxoiB
         H+HpBAembr5ejxEAryCCEyibln+gUphRKxbI2d/VEoqxw0h8Pfzoz48V5VGInuriYcOr
         cl+CC4XSClUeP6v7Mk2kkJ7q395MEnwsyd0A7crgMDTC5ihPmspm70EBbaaqRHYgiZDb
         p2rQ==
X-Gm-Message-State: AOAM531I7KTV6cSdkKRlWgGGhPakvpxHgBWmRqRjnIISdsWhm6efDW4z
        0GCtN0RCb295m/c5uuTaCUk=
X-Google-Smtp-Source: ABdhPJzmYSQuxrxamd3yCEH6wUl8frKVWmgyJEK8eHJP3xuewI0rCMnm4fnQJF4iNhdlxCmJUJKGGg==
X-Received: by 2002:a17:90a:f3c5:: with SMTP id ha5mr6752233pjb.67.1626391269282;
        Thu, 15 Jul 2021 16:21:09 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id a5sm7674379pff.143.2021.07.15.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 16:21:08 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:21:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Hillf Danton <hdanton@sina.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com
Subject: Re: [PATCH] firmware_loader: Fix use-after-free Read in
 firmware_loading_store
Message-ID: <20210715232105.am4wsxfclj2ufjdw@garbanzo>
References: <20210708031321.50800-1-skhan@linuxfoundation.org>
 <20210709091721.1869-1-hdanton@sina.com>
 <d851dd11-1b4f-4ed2-bad2-0c267e3d6021@linuxfoundation.org>
 <3eb42554-c054-6e46-54ce-b9f637b72751@linuxfoundation.org>
 <20210715222817.tjsotu7fuhwz37ki@garbanzo>
 <d17eeb0f-a46e-2515-43a6-36c16002928a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17eeb0f-a46e-2515-43a6-36c16002928a@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:46:24PM -0600, Shuah Khan wrote:
> On 7/15/21 4:28 PM, Luis Chamberlain wrote:
> > On Fri, Jul 09, 2021 at 10:38:12AM -0600, Shuah Khan wrote:
> > > However I am seeing the following over and over again in the
> > > log - hence I think it is safer to check the aborted status
> > > in __fw_load_abort().
> > > 
> > > ? __list_del_entry_valid+0xe0/0xf0
> > > [  348.604808][T12994]  __list_del_entry_valid+0xe0/0xf0
> > > [  348.610020][T12994]  firmware_loading_store+0x141/0x650
> > > [  348.615761][T12994]  ? firmware_data_write+0x4e0/0x4e0
> > > [  348.621064][T12994]  ? sysfs_file_ops+0x1c0/0x1c0
> > > [  348.625921][T12994]  dev_attr_store+0x50/0x80
> > > 
> > > Also the fallback logic takes actions based on errors as in
> > > fw_load_sysfs_fallback() that returns -EAGAIN which would
> > > trigger request_firmware() again.
> > > 
> > > Based on all of this I think this fix is needed, if only I can
> > > test for sure.
> > 
> > Shuah, curious if you had read this patch from Anirudh Rayabharam
> > and my response to that v4 patch iteration?
> > 
> > https://lkml.kernel.org/r/20210518155921.4181-1-mail@anirudhrb.com
> > 
> 
> Yes. I realized I am trying to fix the same problem we have been
> discussing. :) Sorry for the noise.

No worries, and thanks again for you help!

> Ignore my patch. I will follow the thread.

OK ! I think all we need is just Anirudh to split his patch to
remove the -EAGAIN return value in a separate patch as a first step,
documenting in the commmit log that:

The only motivation on her part with using -EAGAIN on commit
0542ad88fbdd81bb ("firmware loader: Fix _request_firmware_load()
return val for fw load abort") was to distinguish the error from
-ENOMEM, and so there is no real reason in keeping it. Keeping
-ETIMEDOUT is much telling of what the reason for a failure is,
so just use that.

Then his second patch would be simplified without the -EAGAIN
condition.

All I asked was to confirm that the -ETIMEDOUT was indeed propagated.

Anirudh, sorry for the trouble, but can I ask you for a v5 with two
patches as described above?

  Luis
