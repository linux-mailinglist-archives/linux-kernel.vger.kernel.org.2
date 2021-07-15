Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578E3CAF20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhGOWbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:31:17 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34598 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhGOWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:31:16 -0400
Received: by mail-pf1-f171.google.com with SMTP id o201so6981605pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 15:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WlElB+10+kIOklb6AszMHdIZvOGTXMtBzbX0xZbQMPY=;
        b=SjPk7sRMAYvcjHm7QFRuR/GoX/fy/NLI/yroJ3H9TZjBXKUuna+Ur8jUG6YRKrvku9
         jkpIM46+F3HiDQSovFmx1J3V9CpzISZOml5FZ7HUGkE/AxxYDZXsC73PbC9h/QPy8GKu
         ST74bAhZjJXfzG7KgBDJ2NT6gAj9zV/KWWhjt7KExLTXSvaCefXqos2uOK19IstOVlJq
         pVDb/jHjjB7urU+wcH84VSne2w1FotnerbLb9/UjAN6ZujM6z4Z8Pa/LgRfurQJ7Dh0n
         992W59ijk+YZO+5qRuPnun4NDRkUZQszr/5/X0qGqmRol/ulvZVuGqH46UNvs1UduI5a
         aX+w==
X-Gm-Message-State: AOAM530aOGtOMmSf2XIAM7kJQC3YcT53bQSNjjKEMwd6kXfo5s24o37w
        EwprybzcEpIuKtoH/itjNco=
X-Google-Smtp-Source: ABdhPJz3exE8ZwSsFCg3utuMfhFe0K6IjQdExV6BpYsax87ohKoLCytkjAvu8j/+981vJSiiPi3UHg==
X-Received: by 2002:a63:5450:: with SMTP id e16mr6767738pgm.50.1626388101355;
        Thu, 15 Jul 2021 15:28:21 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id x30sm7626606pfh.126.2021.07.15.15.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 15:28:20 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:28:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Hillf Danton <hdanton@sina.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com
Subject: Re: [PATCH] firmware_loader: Fix use-after-free Read in
 firmware_loading_store
Message-ID: <20210715222817.tjsotu7fuhwz37ki@garbanzo>
References: <20210708031321.50800-1-skhan@linuxfoundation.org>
 <20210709091721.1869-1-hdanton@sina.com>
 <d851dd11-1b4f-4ed2-bad2-0c267e3d6021@linuxfoundation.org>
 <3eb42554-c054-6e46-54ce-b9f637b72751@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb42554-c054-6e46-54ce-b9f637b72751@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 10:38:12AM -0600, Shuah Khan wrote:
> However I am seeing the following over and over again in the
> log - hence I think it is safer to check the aborted status
> in __fw_load_abort().
> 
> ? __list_del_entry_valid+0xe0/0xf0
> [  348.604808][T12994]  __list_del_entry_valid+0xe0/0xf0
> [  348.610020][T12994]  firmware_loading_store+0x141/0x650
> [  348.615761][T12994]  ? firmware_data_write+0x4e0/0x4e0
> [  348.621064][T12994]  ? sysfs_file_ops+0x1c0/0x1c0
> [  348.625921][T12994]  dev_attr_store+0x50/0x80
> 
> Also the fallback logic takes actions based on errors as in
> fw_load_sysfs_fallback() that returns -EAGAIN which would
> trigger request_firmware() again.
> 
> Based on all of this I think this fix is needed, if only I can
> test for sure.

Shuah, curious if you had read this patch from Anirudh Rayabharam
and my response to that v4 patch iteration?

https://lkml.kernel.org/r/20210518155921.4181-1-mail@anirudhrb.com

  Luis
