Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34F39BA64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFDN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFDN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:59:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4DC061766;
        Fri,  4 Jun 2021 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n/ZdCrMZmv2phQofaog0x+LUYHp73yAorsGrt47sjVY=; b=Oq0hzgm5WO9bsHr3AKXFHe+u6Q
        KIsGO/8vnBr29PZddKRsdr2QSna2j37Ig+2pCCNCTTYdaDANRGUL5f/VjKh1/mMTDC941/sqOy5x/
        i7LdX7du6BEEip7qh6P4jn03J4gG3L6qUcFElwrruRmEAtjtelZG/A6vLGjwFZqlGIA6BQtJzcfcL
        GZaDyHAS3RWWo3c6icd7yqizFkLcK2c381DIVtMviZfUI1dI1kUobQgdaDSqemD7KawGDDxveXaoF
        HQkMuqU0T34L7P1eM2TfWD/xQyNx04W8fSPuv2jCsUkSkWI3/cQceRLAXaOLBjCEGa+4kkbmLRCjr
        vvPvITMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpAJm-00DDei-KN; Fri, 04 Jun 2021 13:57:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BEF6300091;
        Fri,  4 Jun 2021 15:56:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83AA62CCC78BB; Fri,  4 Jun 2021 15:56:57 +0200 (CEST)
Date:   Fri, 4 Jun 2021 15:56:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, mingo@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add usecases, design and interface for
 core scheduling
Message-ID: <YLoxKcDUmo47C1vc@hirez.programming.kicks-ass.net>
References: <20210603013136.370918-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603013136.370918-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:31:36PM -0400, Joel Fernandes (Google) wrote:
> Now that core scheduling is merged, update the documentation.
> 
> Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> Co-developed-by: Josh Don <joshdon@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> Cc: mingo@kernel.org
> Cc: peterz@infradead.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!
