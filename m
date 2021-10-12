Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC7429B37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhJLB7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJLB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:59:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BCC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:57:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n11so12068123plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8a2/JQmuX57q2aJcf/iLLoukKQpiybtglq5HXNGxygk=;
        b=PF5vNeMNX9icXXQWUjw/IfVkmeyvFN8puq/1IIkvkghg5Xvth78HKDEiB2/0abuRWD
         YgylLNMG+Krukn/+gt8Q+0JLMQl8kbW62p/YuHM/DDYZO00e4H9BLLcEojJMsdkbf1GW
         EnF8hdhlzzKwCB5FeYJsPHzJJxT0j/QJoCS24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8a2/JQmuX57q2aJcf/iLLoukKQpiybtglq5HXNGxygk=;
        b=zo9U0KVycfQcL+4bI9fGcu/Ezi5yGj+6+djes15H/ms3EwGcIqaZCaNyqLf9sBAxuK
         7OJSknxfo7SkHzlE0QsBWMZAgbsZKs78R/+bFqqrdulA/1SRgg4EZ+wZDCN7UwWgCEaf
         k/nvJw+c+E+HFlr851eHjw0401XzHUAKneEEc+koMwxy1kPlUZnnkLFFmM1/uuEQGWWL
         TherdcdU/V/xguWVW0k7P+tj4A1EWmaLGoTIAa7k646lFVb+RI0LRXPmJBMxAU51KwC8
         XhQZCu0o6tr9XosrT7XMMrWaKE7ldAYm9lliG7HRgSCm8SibAdP2ju9GPe2q2ST17/3+
         o6Hw==
X-Gm-Message-State: AOAM531xOkkzB+Lo3cglyOLC+znBrGDMUQvuYIOWm9tq6IPXurhf08fq
        YgyY2UdIoXvDl7naqitV3GGVvw==
X-Google-Smtp-Source: ABdhPJzcFDpZfHc3nRVVa+/bAj0gmaEk7b2C9Ped1tQLsHMJultYAblQyLdBAYeCsoDxNIF9/iTxSw==
X-Received: by 2002:a17:90b:4011:: with SMTP id ie17mr2858973pjb.41.1634003828296;
        Mon, 11 Oct 2021 18:57:08 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:61aa:8522:1051:5bfe])
        by smtp.gmail.com with ESMTPSA id h23sm5850281pfn.109.2021.10.11.18.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:57:07 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:57:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2: always set buffer vb2 pointer
Message-ID: <YWTrb0ZXv1HRmtfZ@google.com>
References: <20210928034634.333785-1-senozhatsky@chromium.org>
 <CAAFQd5DLiW23a0U_JjnpvoYmpcbiKbStq7=w=7KvbDP7zLvBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5DLiW23a0U_JjnpvoYmpcbiKbStq7=w=7KvbDP7zLvBaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/05 18:57), Tomasz Figa wrote:
> 
> On Tue, Sep 28, 2021 at 12:46 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > We need to always link allocated vb2_dc_buf back to vb2_buffer because
> > we dereference vb2 in prepare() and finish() callbacks.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> 
> Acked-by: Tomasz Figa <tfiga@chromium.org>

Hans, can you please pick up this patch?
