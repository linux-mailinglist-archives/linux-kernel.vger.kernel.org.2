Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9358A456D00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhKSKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:12:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B808FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:09:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so41295133lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3j0wrmE1CwNjtf7mM8Aojh5k4n4X0js6HJU4WSTIP0=;
        b=bil4k+canV2VmyYaTMWH62UwrjiJME9Vr+ZKTlzUwU3lrcLnALYzhLCdrqbbp//k/V
         iXUUEeenpBlN7HNZORC5/xmBJBvb/oh8mTTXDmzOZ5Kcl24QvYuqHUIoo031hGTmJDWa
         x5Dnjd/4AtZjYwQkvYkbv2c+K9NQ+uL/Cy2mdhOg3k1QOT295PAf5juvEalJCIsMp7TI
         1bg4AhK6ZrLADzJDHEoMF/u27D1156LNMgu8ljfZEai/ndYfBLzg5SvRH7Rei4R2HzCm
         wwYnjTvHxirKpYfEZFKumRUJG9Cl4BMSipZJmxhQIxnzdeTeGmwBohieep1+dBaw9WBZ
         4rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3j0wrmE1CwNjtf7mM8Aojh5k4n4X0js6HJU4WSTIP0=;
        b=DoPjr5zWFfuMSa00jxUSJS0BKIculBw0pK3iFNJKgVjBwGhren5KuH2f3oqUwWKD7b
         iLUy8MoBGcnnBiMlySHb4YyyPiN965fveokj5+bpelVskKxG3AeC4ccI4Y20WqRJtShD
         WBEx4MUYlO1qNjGuiO2so6xS1upNFty2+dcuzRRakY5g0tIcVjg7nkBLZ99/RiKOAHYe
         Iicae++SP6Ks1DKqVBI3HvJBtPbrsjUzCxFqkF3V77/3cnjIqgaX1KnxoRNwD6KhwPD7
         cdhSQJbtjIneDYOR97Aqi61U7G2qi59Ryt3rv0xdKyeowgsxCffaVAMQZN/USzmiS9GB
         j1cA==
X-Gm-Message-State: AOAM531BPGnxF3caS4ez2ElTx+FjOZWYzSMMBqAb2Zz859KIihycP4tr
        oQe9mX60nbSJ6iiRAy1WREKisA==
X-Google-Smtp-Source: ABdhPJzBE64aBlK3lrsKPbUsImaOdnE7F/vga0IkQSkNDo4YvEwvMaLUThmCPh/pUaEM2QLWFJnK9A==
X-Received: by 2002:a05:6512:168d:: with SMTP id bu13mr5171598lfb.401.1637316554029;
        Fri, 19 Nov 2021 02:09:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q6sm315389lfa.267.2021.11.19.02.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:09:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9CC3C102BCC; Fri, 19 Nov 2021 13:09:18 +0300 (+03)
Date:   Fri, 19 Nov 2021 13:09:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211119100918.aperkzcj7at276wl@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
 <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
 <s5hmtm2lphf.wl-tiwai@suse.de>
 <20211117174826.23eakoivl33tawb2@box.shutemov.name>
 <s5hfsrulkxk.wl-tiwai@suse.de>
 <s5hpmqxki3h.wl-tiwai@suse.de>
 <s5hilwph05c.wl-tiwai@suse.de>
 <20211118232628.hynb5vy6phsqj5oi@box.shutemov.name>
 <s5hwnl4fqy5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwnl4fqy5.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:13:54AM +0100, Takashi Iwai wrote:
> Below are two fix patches.  Please give it a try.

They fix the issue:

Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
