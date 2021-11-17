Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5F454D99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhKQTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbhKQTFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:05:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68BDC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0u9G+LODuyaptLsjqsqqaOteSOdlaVNnmJH38eUGRBI=; b=Wkp04OOfHwWGUxrqvlRiC2/Z+3
        4VDFmrn0h+jSSglouc6D7N5j3N2ZO9YPOBKwFuWVL3uvLEbu3nPi6YaMYFIV9oHpcqXjJePLExr0t
        /M6RanjSgdvhF2ZoSMf91eN18PgrVAuY3givxcBYZue1IEOGklWoQk78gNO8nCzdr7wHI8MNIbnjZ
        vFV6zAlE//Xi1WKF48vNxz6r5Sw8VN8/+UPhIE4G2iH0IMwstTfZHgfJ7QyzfOHtKUKYlL5o56mOq
        DwrkGUZml8k2jsgHOXLpdvIwRSBOg5q5AWhmYcQWqSXr50331Fgo8Lv3xCaaKFzW92qp5gCZyLEfy
        5ruv5+eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnQCM-00GYCZ-MD; Wed, 17 Nov 2021 19:02:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 868CE300093;
        Wed, 17 Nov 2021 20:02:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F9C52C928C54; Wed, 17 Nov 2021 20:02:20 +0100 (CET)
Date:   Wed, 17 Nov 2021 20:02:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Message-ID: <YZVRvHXY9/i0Pht5@hirez.programming.kicks-ass.net>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46:30AM -0800, Sathyanarayanan Kuppuswamy wrote:
> TDX has a requirement to use HLT paravirt calls (which is currently
> listed under PARAVIRT_XXL). Once we submit a patch to move it
> under CONFIG_PARAVIRT, we will drop this dependency.

Why do you need to paravirt hlt at all? Can't the TDX thing simply
install a different x86_idle function?
