Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC73BE7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGGM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:29:29 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46887 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGGM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:29:28 -0400
Received: by mail-lj1-f182.google.com with SMTP id q4so2422969ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 05:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:to:in-reply-to
         :references;
        bh=zfK5nIKvqhQEsSUONceEfuKD/z7zuTiP8KIzwk65vxk=;
        b=TD476vd/wTuu7X9+0pHVJ8bxDUew+ueRXKpnt+mhTeZ89DgHTsHilyHXCWhVwLtDn8
         EOUq1DCkn+FiIHkYbRImfjkfK2r5sv63Eg47M7k6Y097/hTuGQn24fbQG0TvVvt9YO2E
         4G+PxnPKtUXc4i4QVs6M1dxEAS8OeVvSBzaN6Sco+koBSKLCLxHRZrqO4ecPaqHdQME4
         o13nDHautpAsi5b0XD2j1R1ICkkZs9e7RNIje1Z7WmEVxiIumgKSFxzA9Y6hCKWmXAd6
         MqV90n63ll5QuC1jy6EmhhP92SEESsbWrgPYBYSYHiv82xEfi/JAZEMP/DIJKotwL+tt
         9h0Q==
X-Gm-Message-State: AOAM531LMxfH5ZfQ6Etf0cdoVAbEv7z5CL3szOZXI2VTby5T/R8DXL4+
        OCuUVLPCHQbjR2/Lt+uiSEYUWP+YKjy8gBkp
X-Google-Smtp-Source: ABdhPJxIrWgEtpgEupFokecChm2ltIRw/0mHgfopr6oXzzhP7gru45c4olz2EyNJX8x47zeXHVZvXA==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr17182132lji.121.1625660806972;
        Wed, 07 Jul 2021 05:26:46 -0700 (PDT)
Received: from localhost (88-112-11-80.elisa-laajakaista.fi. [88.112.11.80])
        by smtp.gmail.com with ESMTPSA id t12sm1686725lfg.148.2021.07.07.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 05:26:46 -0700 (PDT)
Message-ID: <60e59d86.1c69fb81.e047d.93c3@mx.google.com>
Date:   Wed, 07 Jul 2021 15:26:45 +0300
From:   Hannu Hartikainen <hannu@hrtk.in>
Subject: Re: [PATCH] get_maintainer: only show lkml as last resort
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
In-Reply-To: <19a701a8d5837088aa7d8ba594c228c0e040e747.camel@perches.com>
References: <20210706083354.214826-1-hannu@hrtk.in>
        <19a701a8d5837088aa7d8ba594c228c0e040e747.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, and thanks for the review!

On Tue, 06 Jul 2021 09:00:42 -0700, Joe Perches <joe@perches.com> wrote:
> Almost no one reads lkml directly anyway and I rather like that lkml
> gets all copies.
> 
> This allows lore.kernel.org/lkml to have a relatively complete searchable
> database of all kernel related patch submissions.

I hadn't considered that and the documentation gave me the wrong idea.
I'll submit a patch that clarifies the documentation instead. Thanks!

Hannu
