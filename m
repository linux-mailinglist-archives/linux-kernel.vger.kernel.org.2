Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0133F7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhCQSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232932AbhCQSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616004725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M/8wk+c8uCxkBKXzxhY1/fHK+UnPj3X55jlGEDBVrLc=;
        b=gd8+NSTsL0klzI+kyh0qbyhAuGYwj7ftqtUDCt+Ih+/qf1b8H/F/ET+54H93nnsKPjBHpS
        Bmzws0/nXeYHkLoslvKr1OZIEh1AmUf7Nz9qUzGO0IsX1TvRr6wcwPlJKBApX1S4teycrF
        u8BPkU618hvWCProC4QmV7X/zvVry1Q=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-aAaDuA1lPFCqoYI_4keYlQ-1; Wed, 17 Mar 2021 14:12:03 -0400
X-MC-Unique: aAaDuA1lPFCqoYI_4keYlQ-1
Received: by mail-oo1-f71.google.com with SMTP id k26so19709164oou.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=M/8wk+c8uCxkBKXzxhY1/fHK+UnPj3X55jlGEDBVrLc=;
        b=Rni0gwUCqjkMiaht7ZjsAU+84Z213no9LSiZKDyadn4Y82RThTTM7LVzyrLLKRmupZ
         /lekciCRDvOM8NfYCTq4piEhzBzfbY7P5z2TjwtG3FRLDrriq5J6IuD02GNB/2DBDSoj
         +Y7atQ82KwBr0OjfZwB6lq7U5ovnreWCsxvYlX31Y2FvrloJmUsyoiRxEHPx1Q7dvRQc
         iqs3ubIkS0RN8J46U1BcmP7pdD65g2tEzl+a7a9s7+6/up8SE995i9QAs6jtc9VMP+HB
         9X6gEzjkmz8ACpqHeKDpHY7dIcIHPnz49WcFlO4j2KqfGji9iF8qbcM3ezm7EZxtbLRw
         c6dA==
X-Gm-Message-State: AOAM532hu6jcBiMkn4e/fg+UrpwlZKAGmVx9iy2JyJF/DoK/P7hqCgfq
        T3mfWG8dmzgu90JIpBlP2evcUIWKXf3MHWzsC1+VIvq+kky6hwOu6iDKh3aAqULFZx8uyEwVg4d
        vffnh89blM0J5MkdLDN6AIlZ2Rqa9xkU1ashanGT9joDiq+ZS5K0hXb169YoybaUyNT3ejbfGkQ
        ==
X-Received: by 2002:a4a:d1da:: with SMTP id a26mr4317800oos.58.1616004722670;
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww8AhR/73C+UNIg8Lem4xJuZS6lxi84nBv5r8MgLJ4vyoet3NjRw7SHlvEvBi5lLx5F90B2w==
X-Received: by 2002:a4a:d1da:: with SMTP id a26mr4317776oos.58.1616004722394;
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id x135sm6603556oix.36.2021.03.17.11.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
Subject: Question about sg_count_fuse_req() in linux/fs/fuse/virtio_fs.c
To:     virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <810089e0-3a09-0d8f-9f8e-be5b3ac70587@redhat.com>
Date:   Wed, 17 Mar 2021 13:12:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been familiarizing myself with the virtiofs guest kernel module and 
I'm trying to better understand how virtiofs maps a FUSE request into 
scattergather lists.

sg_count_fuse_req() starts knowing that there will be at least one in 
header, as shown here (which makes sense):

         unsigned int size, total_sgs = 1 /* fuse_in_header */;

However, I'm confused about this snippet right beneath it:

         if (args->in_numargs - args->in_pages)
                 total_sgs += 1;

What is the significance of the sg that is needed in the cases where 
this branch is taken? I'm not sure what its relationship is with 
args->in_numargs since it will increment total_sgs regardless 
args->in_numargs is 3, 2, or even 1 if args->in_pages is false.

Especially since the block right below it counts pages if args->in_pages 
is true:

         if (args->in_pages) {
                 size = args->in_args[args->in_numargs - 1].size;
                 total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
                                                  size);
         }

The rest of the routine goes on similarly but for the 'out' components.

I doubt incrementing 'total_sgs' in the first if-statement I showed 
above is vestigial, I just think my mental model of what is happening 
here is incomplete.

Any clarification is much appreciated!

Connor

