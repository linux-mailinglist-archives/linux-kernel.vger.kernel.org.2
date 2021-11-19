Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8B4574A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhKSRAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhKSRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:00:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xhr+GcGAMXbhD07T4D5ApdgD8zRu+d5CLLKsjxT2sR0=; b=dqoAM49wLGWNE3RJGkMgumnG4F
        Q1Jyz7ZtveskeLorqk1PYeUDpTY/mh7xZYtozxZX8QYC3DdwcThKzEvavqeLvzjUzLMruic9amvBt
        bhbpdRB/AokmvMnbYWTnJAD71QSwrm4sTdSnYxksF15L1VpE2gzbXbo5VNSPs36s2MyC/ATSLWvJu
        plA3cQNUI6zIWoJ0dpoCWYAI0naomD5Kyvo1NLYisZdT04CJ4QD8bOcohgfZjRQjF4fBjmNqN4V4t
        23Wn4OR9uPixhFPJUPof0SCbUnnxuefDxsctKIMt+N5CHh7/4qRDxyYVXApWej3PQt53ok8wql51u
        og/AmxEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo7CP-00GwUy-RO; Fri, 19 Nov 2021 16:57:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6D9030001B;
        Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A4092CA10EAE; Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Message-ID: <20211119165023.249607540@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 17:50:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH 0/3] x86: Add GCC-12 features
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These few patches make use of recently merged GCC-12 features:

 -mindirect-branch-cs-prefix:
    https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
    https://bugs.llvm.org/show_bug.cgi?id=52323

 -mharden-sls=all:
    https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
    https://bugs.llvm.org/show_bug.cgi?id=52323



