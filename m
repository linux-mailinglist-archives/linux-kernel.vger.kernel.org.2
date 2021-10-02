Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766541FD0A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhJBQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJBQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:19:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1DC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:18:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s11so12367072pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+VB9FstnCFXy8utS9z2gbROEzR/mAbwOOQhx18Q89e8=;
        b=VaNDVLL3oXpnrb/yNCNsNthIFxDdM6MBjQsIBAZR9r8zF4iPdFhGoLAG8OUDZa2qiQ
         iORY1rvWAdqhCz4GLShFjVSoJC2Dak1DV3ygFUumVe3tlx1/JbE+AcQmGQ0fJt+S90YH
         j6B0Jfx+fZWn6rtHbgCggKOY+OJdqnpV6JCmcPnGleGOv+RBuVFq1qQL01IkmlbGZzD8
         AnWF/iqMcxdwR7jsIyCOWuC0ldsZyyypB5eUaDlsxZWjFjekqh8jxWuRRRtrqly/1YAg
         Bb5WoyOU7JpvylYT+w1thN+zPqiLnOxz39TU0phYEtIGxk76gd8x2DJ9UqJeLBf37yUH
         6kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+VB9FstnCFXy8utS9z2gbROEzR/mAbwOOQhx18Q89e8=;
        b=Aqb6frP4rBuca4VUXROPuMyXYGZmKa1zkNVpvNpgn1ar7EY5t9X71mwD60vV+8pKfh
         lXuf7UMwgmEALL5hl1aMkKawaRekwSv4IXmRpMUHtkDdxNuGMP0csgxKqQq+ZNMnk/Sn
         11TK6cBYB/rWyz0hrZ/Qi1175BzdM7JJm6f9c4k+SwZojttIl3KMaVvTA4PLgKNjUvjf
         V7pUzySKP6l/B6OuwC4da6bb4Y/LAsiEjUDFXndM9sjd7bmIC8cXOXvcwff0XHEZZQnp
         l0yp5TFcVUfcunI5uvQzSJnOhYdh0rBQJmwyaZKN/KWQdbcA7x90WRYuwpG+U9MVMdAS
         J+nA==
X-Gm-Message-State: AOAM532J5f4Ksml0hduAu0zEABRsD5u5psuETIMO0Xs4r+osAHzV8sHi
        5Fi7orQb0VEyVfZsK2nkwcYTzg==
X-Google-Smtp-Source: ABdhPJxASmljlbJlAX1NyPTdQFN+RGGenb01Tv1j5ftB6+Z4G4f+YlLcOCD7S5Fk5ggg1J61DVMxTA==
X-Received: by 2002:a63:1262:: with SMTP id 34mr3429401pgs.356.1633191483204;
        Sat, 02 Oct 2021 09:18:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j9sm9324464pfi.121.2021.10.02.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:18:02 -0700 (PDT)
Date:   Sat, 02 Oct 2021 09:18:02 -0700 (PDT)
X-Google-Original-Date: Sat, 02 Oct 2021 09:18:00 PDT (-0700)
Subject:     Re: [PATCH v20 00/17] KVM RISC-V Support
In-Reply-To: <CAAhSdy1yZ11L=A3g06GXM8tFtonBX0Cj5NDyGHQ1v44vJ8MqSA@mail.gmail.com>
CC:     pbonzini@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, graf@amazon.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        philipp.tomsich@vrull.eu
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-b5a035ae-a545-4c81-a8d9-301c6f7e6982@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 04:58:41 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer, Hi Paolo,
>
> [...]
>
> The RISC-V H-extension is now frozen. Please refer to the latest
> RISC-V privilege specification v1.12 which is in public review.
> https://github.com/riscv/riscv-isa-manual/releases/download/riscv-privileged-20210915-public-review/riscv-privileged-20210915-public-review.pdf
>
> Currently, the RISC-V H-extension is on it's way to being ratified.
> https://wiki.riscv.org/display/TECH/ISA+Extensions+On+Deck+for+Freeze+Milestone
> https://wiki.riscv.org/display/TECH/ISA+Extensions+On+Deck+-+Ready+for+Ratification+Milestone
>
> Here's the announcement on twitter from Mark (CTO, RISC-V International)
> https://twitter.com/mark_riscv/status/1441375977624375296
>
> This means the KVM RISC-V series now satisfies the
> requirements of the Linux RISC-V patch acceptance policy.
>
> Can we consider the KVM RISC-V series for Linux-5.16 ?

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

IIUC the plan here involved a shared tag at some point, with most of 
this going through Paolo's tree.  If you still want me to merge 
something then I'm happy to do so, just make it clear as I've mostly 
lost track of things.
