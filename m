Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93D3A7769
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhFOG4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFOGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:55:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6LV9BM3Pp04bKu2UoJ3ix0LclPXqE12gKen1uMnIsOs=; b=M25VAanLtpaXgntkN8Qf+Wt8ZI
        dktarA5AKe+TZ3bnF1bMS18t4h0YDZgtYjpV49hYatGmyAW1TuO31f5dM3blXZ9+I8qplH81hwJHg
        hxDRsnRM8GBHA8ZjuMqH+/pzOquOfj0Nv9GqDHPLAv4kfDubE/mlYKQP1dJ7Mqn7AZw5NP7e45rMr
        JFnOj+0j35MeAzCxCHEsryXkUyY6ajxlYZ73OTArbbbLSMmwe9gHPieS3frliTgL8vIeYtc/99fZi
        B/9I8AFjZ3iloa8gnLwZjHb8iwAyPOQvAUcVL1I/JbB+l+MVlCY+qAm1N6XQuFpxBrUE/Rxt/ig67
        aYZrJp+g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2wq-006BNx-Ar; Tue, 15 Jun 2021 06:53:23 +0000
Date:   Tue, 15 Jun 2021 07:53:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/uaccess: Add unsafe_clear_user()
Message-ID: <YMhOYKM5+s0wUoeP@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <67eedb69ca81e5a4b16459a4c61f99e64cb42675.1623739212.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67eedb69ca81e5a4b16459a4c61f99e64cb42675.1623739212.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 06:41:02AM +0000, Christophe Leroy wrote:
> Implement unsafe_clear_user() for powerpc.
> It's a copy/paste of unsafe_copy_to_user() with value 0 as source.
> 
> It may be improved in a later patch by using 'dcbz' instruction
> to zeroize full cache lines at once.

Please add this to common code insted of making it powerpc specific.

