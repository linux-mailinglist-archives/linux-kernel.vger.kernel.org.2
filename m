Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26353979CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFASMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFASMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:12:46 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:11:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i5so15205676qkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wRwteCaGKZ10e8+sBtL3qGET4PztXqRbJxpQswQ1wZ4=;
        b=Xf7CSrcx0gZc/sw/u32fm4fDbUmIKsXJ/VYY3b6I2TINji/gEViOo0+/3eu+yW9Qgd
         fIGeNKOgrvvoXSlKowbNVeKQqeYrgIx8R+UG5xh83h5SLOwv/5uFjJDNSoddC30OLOAP
         eeb77BNO0SGqOxoLj3XL020OBNHpc15BDfmueLRDjJQfWJptI6v5o1b1rHvOJRAOVKlt
         VNpNaJpcQ4vHbnLaPIFMaxp4PkgtqZM58T+bwUwvwAp24ndzjiN27Y317PjL5UaZhW2A
         4MHWVeTTB4dK7LEaSj2Ky8gxJUKpLuudM6imShkOBqj5RMusHaTKIjTFUXCuCa94uHDl
         W5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wRwteCaGKZ10e8+sBtL3qGET4PztXqRbJxpQswQ1wZ4=;
        b=O5Nus+TI2h/6chvQB9qJtX7lCUsRtd5OfseaDgzan5oyRqewqaggn7iFydrDzTzgn9
         xOAYyHKlueTYLqmMVkbdqfOWLe2mvY8TXeu+2ECGQ7V/rNUeCHIjR1AX397jAPo8U1yy
         DpOudLGi1HQqElpgS4iqA6eTP/clr161eTfK0lBZHaX+S5BHmwg4Kdx27usKW3mAVj7w
         AZ//hYG2wQ8lydS/Ne0ClMs3ossn3jQevuro9vZ4m6Vi7GvtTVXqGQ2g2LLYMClTHreE
         az5nEjdob7/lLVdqJ0ssbVPDCqf+OobfkZnEZ3ir7pEv9AmtXDbi0CZXO2QK4KSv9JQ5
         /slg==
X-Gm-Message-State: AOAM531FSOPMquYFKsbwuqcj8dW2HBd/qBkB2ofIoufeWObPnG4dtVTi
        qD820Zi1H90Ih6WWcYYlbViHbA==
X-Google-Smtp-Source: ABdhPJyH06WMNFVFIh2tqA2mZ/X7OLcXSDF3vAAIrUB8u/TcRWHA6zy5sI+bX9Bd1/r6Bup6LtlwYg==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr23666624qkd.430.1622571063443;
        Tue, 01 Jun 2021 11:11:03 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g5sm10470430qtv.56.2021.06.01.11.11.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 11:11:03 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:10:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mike Rapoport <rppt@kernel.org>
cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/setup: always resrve the first 1M of RAM
In-Reply-To: <20210601075354.5149-1-rppt@kernel.org>
Message-ID: <alpine.LSU.2.11.2106011109020.1045@eggly.anvils>
References: <20210601075354.5149-1-rppt@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021, Mike Rapoport wrote:
> 
> Randy, Hugh, I'd appreciate if you give this a whirl on your old Sandy
> Bridge laptops as it changes again the way trim_snb_memory() works.

Boots and runs fine here, i386 or x86_64: thanks for remembering us!

Hugh
