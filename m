Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8000E3B13A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWGFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFWGFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:05:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24423C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:03:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G8t3W1lFmz9sCD;
        Wed, 23 Jun 2021 16:03:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624428183;
        bh=NUxD5IWRTrB16e837MNcOneqkUUtN5EljoXA6mpYpaE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KMvS4/8b4VKbI66mYHHHYcRI/dKgGxZL5gX2zivwwkxMRfDBmgjx+yW4W/gC0lxxE
         bW3bhnqaEya/Ums/FJ952VC/tTWiJilyInK9Q9BZUnWTcmxeON2/uznwkXh+BWWmxP
         trsdmjqIGi0l2cnrASRjGQ75z2V6wyGTfcaQvcZyjvL4I6yasyZpb/j1rz6+CNnwHB
         n5EKWicVw1JvKDdgCy6d7sCaqa+j/woswtVU6iuGVUJLJBxb8OYWscioeyHJIgAVzE
         gzrExBPc0arXpKQyPd5hHudhoipL4d0v4T1FJxnRN1iy8v9f2ONBcLiZHQcCwj4jKi
         9NbuYcIE3WnPA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
In-Reply-To: <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
 <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
Date:   Wed, 23 Jun 2021 16:03:02 +1000
Message-ID: <87r1gt15k9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> On Wed, Jun 16, 2021 at 04:43:03PM +0300, Andy Shevchenko wrote:
>> Parse to and export from UUID own type, before dereferencing.
>> This also fixes wrong comment (Little Endian UUID is something else)
>> and should eliminate the direct strict types assignments.
>
> Any comments on this version? Can it be applied?

Yeah I'll grab it.

cheers
