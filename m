Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8973B89D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhF3UlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhF3UlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:41:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25938C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:38:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z1so4270421ils.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuEwF44PEA0Pv7slvdt7r1zkEZ5xYY1EblWbq88/Fmc=;
        b=bEBuP/yawR56TgWmm90eOVPFFVCM1vVKqtk4mfU6oVV8TJPIKQAuarqzx/bTmFYo2t
         C2pM1MHTEF4rDy0w8vyGS2E+1LioN4bc+NrWglVsKCT5tFJtOIXpoa2U4V3w3bhJx9yj
         5LVG2QJi+jKUcxEZj+A6UVEGR/CmGbrDAPFUsTy0U4//h4ee308SMpNFklyRSlPRHFWi
         MWuCEUmM3cUmotnR6H+SI5cKgAMPj1BZllH/Jv+M3bBmTkHTOKvYPk53aExckpV0Mm4x
         dKS2DYM5W9YSy5Gs1yt1z57LSfDTulJ5m3cCnvUmFQ4PzHVfFln+AZQrp/Gi8u6ju3Nn
         Jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuEwF44PEA0Pv7slvdt7r1zkEZ5xYY1EblWbq88/Fmc=;
        b=azQ/vHLYZ4+JYBUSzulkMIYMk0j4zAB7dFapOJ5qyBwliU28gXMEXruQ+2zN1iipPr
         O+oqxcLrIwqiJRMiI5f5M8MxPgnfNqhDet20TW1ddO8GvCF6y2pNzilDoBy5zg/+es07
         L7o3/8ENgkvCNDzocQuxACkKzUfH0CZwVtOhmVyMadsE8d8S2IgbbyAXR3XzqMUyq+81
         jWN1rbvjn7kITF/sYawId8DtEt9qNVw+L+4xGVY4uuyRcrxtrpUskfGqFpHkEnY8lKwB
         YCbtxbqjTvJsTrSuwH2jSwky6nACRbovOYVIOfEVh3LGj6f6W0JKOorkULClSzpM2vU2
         E/hg==
X-Gm-Message-State: AOAM5331ZJ7N1e1VzFMXpjmXMXjvoc+amIBfry1MHwpUngw8no6vSJru
        zFxLvjnuTg52eil/pvbIuJ6V/d8d92Fq5g==
X-Google-Smtp-Source: ABdhPJyeEk2UIVLxvqn9I/GdrD/fANuzFu5qk6dAOoz7IijJHD6MdbOEAqlqm0mLJm1hArh/RSzDkQ==
X-Received: by 2002:a92:750c:: with SMTP id q12mr27043167ilc.303.1625085516578;
        Wed, 30 Jun 2021 13:38:36 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s2sm9791102ioo.45.2021.06.30.13.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 13:38:36 -0700 (PDT)
Subject: Re: [PATCH] block: Declearing print_disk_stats static to remove
 [-Wmissing-prototypes]
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210630203720.208003-1-abd.masalkhi@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5742bdb2-6d99-f32d-33a2-b9c5f51e9345@kernel.dk>
Date:   Wed, 30 Jun 2021 14:38:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210630203720.208003-1-abd.masalkhi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 2:37 PM, Abd-Alrhman Masalkhi wrote:
> In the first patch I have not defined the print_disk_stats function
> static so it triggered an [-Wmissing-prototypes] warning, fixing it
> by defineing the function static.

Just send a v2 of the patch, there's no point in applying a known
broken patch to then just do a followup of it.

-- 
Jens Axboe

