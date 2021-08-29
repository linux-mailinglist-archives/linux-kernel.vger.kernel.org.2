Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC03FAB43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhH2MJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhH2MJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:09:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D84C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:08:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q21so20483396ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+swTcS+LZnxIermaKa3LHQgsSD1cR5lC/MsDCKUum4=;
        b=aYxv1Rj/ABPzkGnAcW5pKXkr02VN5YLA0N/YNOj601SA4oIHrGQ+PeajV0okIaQpSR
         TihF223KlVKNF7nwT5nDMa4C/umw81xwM+tRuCIkufYXl/Q2JaeP6MpCt3Bi+DLLipEU
         gEcTUYOzsXn1k2JgkJdt4pkDeEZzBOBQ/9mylCwbAQdKQ+PetXdbsMDfNCE8z6kCOv01
         93Qc5qHnz2BEqBsDMkBp2uWHKdGbQJJ1OoQc+5wpQqWYNKs077zZqyyjlJEAoBo+xmAB
         bHdxf7UldqVjntC8J01XMrnUOFP6fHExWT2rN6YDZqZEbStV/QWpnfZAqN0ETH4Ncg8e
         JAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+swTcS+LZnxIermaKa3LHQgsSD1cR5lC/MsDCKUum4=;
        b=URweCRMwDiGin9s0Cy9dHdfCk+8jVBKkzjSWpoGFLSw2u2jVYjuVrReeG5Jg8XT7JL
         hWT3KCMgPBB7clJAeetBRROcvKkTa7/9cUYbDPdIQdLWsMoRA+kcp/UxdRMUtrMZw3SZ
         XUQRwf6vkmJ0t2HGL9OWuH3Z3BYNIVuWreS2dY4VE0vaLSDWk8DxGO8rnY6YItyjS/nZ
         X3E6S9kg/OJ0McIQfaE11lHwa/y9wwxltswIMXY+B9hwaKUrB6Tr99P69ByrMiO+BMPk
         EeSF9nD650AbpU5Iy8ATmZMBonqGgyak44IV+yUhQosWJNsdlo+wEm6cLPCmCabhFhmB
         u/9A==
X-Gm-Message-State: AOAM530RqorrqkEn0vicpuK/YcT/jjg7EehTQJoJf7GrQqpJcsAUFQlS
        QqLFC6YsqGhndvgV/hHQ9II=
X-Google-Smtp-Source: ABdhPJzAPB8Uuo7S9K+anDDhJ0eV46NDeetCK3i/JuyKL1vecUOdBoe4QcwF8c/Cm1XmC3Lkgola7g==
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr16102304lji.21.1630238905641;
        Sun, 29 Aug 2021 05:08:25 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with ESMTPSA id a3sm1421362ljj.122.2021.08.29.05.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 05:08:25 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YStM2wxtkDAnRemt@user>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <904b3dc8-fa52-a410-c9d2-f6a1d85487fc@gmail.com>
Date:   Sun, 29 Aug 2021 15:08:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YStM2wxtkDAnRemt@user>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 12:01 PM, Saurav Girepunje wrote:
> Remove the condition with no effect (if == else) and group multiple
> cases which execute same statement in rtw_mlme_ext.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>


