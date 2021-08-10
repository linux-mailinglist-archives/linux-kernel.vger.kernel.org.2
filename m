Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1D3E5A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhHJNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhHJNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:01:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E984C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:01:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so4316704pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pSUZ1V/TT3GxnZ/SQCtnrpNBlM+RKsjso4hfU/Kzd+M=;
        b=seVT7c78HqYysBY0+TO7yVtcssykcqXRPxR4swEdDLNIkiVACBQO7y8Zs/cxbyqDcP
         RGIbuMcKu8DndKAPDzCHUHXE3cQ+nMGa81IPBQOAgnIuOKR5ep4iBfl5CTqBbG2knG5+
         +Z/wSlWaevje/G3ktuzZ14oZAXi+gyozYBZLjvZr6+4JL8x6nrjcOpLpLvWZWccZQGHa
         g8dvZCXPjlGWiqLsHUwGelCWtoH5nn5gTn3k7lepQahjkBEWtbEV8G3E2EGDg2e8Kj91
         9tiXvWZV9a2Gi+ANXDw/j6EYiVPXOdivfZj5kl09P12mhCEBxQN9Fwwn+SB/gMfNwAkw
         CjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSUZ1V/TT3GxnZ/SQCtnrpNBlM+RKsjso4hfU/Kzd+M=;
        b=pQ2VWzgUmOn6B9nT0C1oZu1vVRsZm9KNw061WMYGZ4pffeuVcyYgmu1OdnA1EIjNEp
         9JhFkxZDRIc/38eAZlmalF4+uPMMl6TVRR5pdbUiarbpRhP3uMFIyJ3BBU1GNnWuHzmN
         rWe+u++sKOQFUAk3f+gmeZsNh3PU86a6TyWwhuKiHFofVEbhxqBYEa/EjjGvtcN1BA7p
         Haja/Wit+YrAl2dhbWa/RY2qC3PpY+Mh8B6yMMgO4bQkVTiFEzLS22w9JANCnIiV/Ix4
         ucj5OL7TGIB4qRs5qk/sIV1EqLR9x76vf2bn1iK8p2pv+zpQgtth6BnND0Pied2VjPT2
         JXFA==
X-Gm-Message-State: AOAM5307SWvgbNc5giJuJUJ0h2BhRN0Clxcign29t2SqqUD6EAyo6JYG
        PFD6UyjbqsvIk+uiZLlUkxpjww==
X-Google-Smtp-Source: ABdhPJyMtSRuDNVK02DsgMAnla5RRq9IyzqIWOXPwpSmIGPzjS2YjIqAyP5ag735Uktpxwnm0Ynctw==
X-Received: by 2002:a63:c04a:: with SMTP id z10mr862519pgi.99.1628600496790;
        Tue, 10 Aug 2021 06:01:36 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id n11sm3260977pjh.23.2021.08.10.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:01:36 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210810203135.7eb7b01a@canb.auug.org.au>
 <20210810125813.GA9836@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d4a112b-8ea0-3440-6c63-c3d1463b7577@kernel.dk>
Date:   Tue, 10 Aug 2021 07:01:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810125813.GA9836@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 6:58 AM, Christoph Hellwig wrote:
> The patch below fixes it.
> 

Added, thanks.

-- 
Jens Axboe

