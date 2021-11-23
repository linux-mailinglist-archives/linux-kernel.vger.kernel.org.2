Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74A459D41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhKWICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhKWIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:01:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AF0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=14gaM9WLPHwSdnZuV8BrHtLT1kO2Ty0JKH3wRz3FBrQ=; b=n1z9qE9XdHNYZqoN1XrHyLb6W1
        PajbbHMCYZc5kyAOKpltdflQMNDjpPy61d6exZHsHMl+jdcbeojfdWC5U2Vywmfpx5IeqbEarXxZK
        AUCTNSb+7rMUaNEiqNdUKEfT3em0X7A8euGybKZD0mfOC98W1rvDTQEuounhdvlPimItnth/smwI7
        1PkU7SwIbAHOjxcoqY+iN0nEgQglMQonRJfcvyDRsDHG0BDCVCzfjtqep3nbrtfTGbb1mZn1tip7a
        CY5F+kPXLvMUvkGzj30eHdN68VrmnkJqEoYwQgKLyuYc4QeQptPQ6nbBj8yDjfZFvFB9RYrSPt+pO
        qItkdlcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpQhP-0019DS-OQ; Tue, 23 Nov 2021 07:58:43 +0000
Date:   Mon, 22 Nov 2021 23:58:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [RFC][PATCH 0/6] x86: Kernel IBT beginnings
Message-ID: <YZyfM/gUoPV6p+30@infradead.org>
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170301.764232470@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is "IBT"?
