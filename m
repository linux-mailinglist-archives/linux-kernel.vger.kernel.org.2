Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4270144734E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhKGOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhKGOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:33:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBC2C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:30:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z21so6522695edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkZdp1HkaN3DnI5e1g9E/OFtiofaFNZ+ta8eLRiYVVI=;
        b=fvhz2TTGFAIoGB5s9RnPhgBlyRYo5MFtXomKs48FXDRMgCJq3/OozSumN8x71msSMB
         zfz5M/QiKWSN6gU368BoOCA/YlZLnxcS/j+4ZgxCXr7GAWvTymFPg2XYfhY0tmrZ+BHw
         ieYkFfAX38VLzufOO0rTTGMqjE9uz6QJVcnO9JrqN2iVrkffPskOSLJqsFAh0+7rj0xm
         A0YQiORaTQloUWDLR+kANXDPB32DwpvuBKDA5WSXK+0yCHd/a+JRxfdl+RxBm2EwRCaA
         1VFGA3W/0AF1Icgs1o7T5QvQMcjHz8Wyua/FNlXDW8C0SJQDF3k/duP88ztbMZmyT2IR
         IOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkZdp1HkaN3DnI5e1g9E/OFtiofaFNZ+ta8eLRiYVVI=;
        b=bXwbkiDmVkJGnm/M70eTnF4/0bXlRYce8HjcSN7+GHUTZ2pjklVG0QPzN/Ug5sI24v
         vO/u/7vmvWO2RVOiw/w6vsE9LlAqzSyzlirU07ahuMlXf4cBls8OEuxTjFXL2vo3/G9Y
         iZWZqEiddH6PHf/EEh8ZSU1z/wfOD+q1QDmekIJ0l5VBkBWVf7x0fFXAWQzTHRfwuEj/
         DyTs6ysdpt0uYprUjb51M1o5ZWXiHw6/u3KRUIaXXokmFjOokHry7iuFnYqhvtmRHmS1
         i+62CYr6yxlnWljH17ZKBCNXetWiiqtPnCQkHPjTAAE/xQ14S8jz2WU0ktl/AP2gBawj
         WqTg==
X-Gm-Message-State: AOAM530LLfuxb3+A1SuLvjAXbPidE1eB2lSgQOcczgNmPvHgh1IwPj1Z
        o1ElA3+ZToepZ6ZZuS+TfVk=
X-Google-Smtp-Source: ABdhPJyeP5nq6O6JqBDX0APvDtKq/YNSc4d+jjr2BnrzBnb5Hc61A5o3DGUdMYA4GZ4/uqwrJqnXuA==
X-Received: by 2002:a17:907:7f8b:: with SMTP id qk11mr89725169ejc.313.1636295434776;
        Sun, 07 Nov 2021 06:30:34 -0800 (PST)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id sg17sm6987699ejc.72.2021.11.07.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 06:30:34 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Sun, 07 Nov 2021 15:30:33 +0100
Message-ID: <1887847.D1JkeFG8k8@localhost.localdomain>
In-Reply-To: <YYff78mUK+9F9pEN@kroah.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com> <2284999.BhpMBdGVLH@localhost.localdomain> <YYff78mUK+9F9pEN@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 7, 2021 3:17:19 PM CET Greg Kroah-Hartman wrote:

> No, your change will go to the staging-linus branch, as it needs to go
> into 5.16-final and get sent to Linus much sooner than 5.17-rc1, which
> is where things are being queued up in the staging-testing branch at the
> moment.

Oh, I didn't even remotely guess that this kinds of patches usually go to the 
staging-linus branch so they get sent to Linus much sooner.

Thank you so much for your patience and for taking the time to explain the 
workflow to me.

Fabio

> 
> hope this helps,
> 
> greg k-h
> 




