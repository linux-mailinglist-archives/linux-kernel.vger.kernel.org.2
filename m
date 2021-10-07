Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE530425EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhJGV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbhJGV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:29:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F58C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uib4xuJP904MSgAbITIPa9Xod+deKzp/nfEIpfSyZ4U=; b=R8SsrFST0NeMkyb4vr15nflOAz
        n4XtOzLzu+7DoWoqKL8Zhw5uvqcUZnE/qEhwZr1Lq5JD6GOymi2uVfUOXTrcAWOpSTrgVRG1jAfW2
        KMP1F8phiI5oVj1ApgKgGToga7CmnkZ+Jv5cMV6QLobn+LOuUbgVYVn2fuluONyt9dBydSw6QwAry
        P6aFJmVu9Ok8yolU+p2wYLsGjZbtD61yBqUnsfuNHTpB9LPtKFeXspu+/XmjDLtA//yV52QAQHcXw
        6DPi2PnTJnhaw4RtHohz+bPHDn0/lX+1i3N0hmUtLNx940EVnaxR65awz5EeuUChfpAcfAWoycso1
        fA/rWT+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYav1-008YHX-Vp; Thu, 07 Oct 2021 21:27:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABFEE300243;
        Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 977642D188962; Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Message-ID: <20211007212211.366874577@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 23:22:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: [PATCH 0/2] objtool: Avoid pointless modifications
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While chasing that libelf warning, I started wondering why we're re-writing the
elf file to begin with, the second/noinstr pass shouldn't modify the image, so
we shouldn't end up in elf_write() in the first place.

These here two patches seem to cure this and should thereby also improve
performance somewhat.

