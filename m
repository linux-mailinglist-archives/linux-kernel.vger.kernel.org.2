Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA3F2E74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhHTO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbhHTO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:58:07 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:57:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 48FF41280D3A;
        Fri, 20 Aug 2021 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629471447;
        bh=T8fM0mMRGQEJQ9wSjnQ4z65LLLqaO9J01HLIBiCTQuk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=efYeKvGOmb9BLn5/gUTYk7Uqzr9d7FhsQAJVFS50qmzQjZoHuYPMhtEsw+Rjz9F/9
         LZn3QfaPBp9CYGY8IC86zNe4NL9c+trOENn53Y1jvqONfq2dZhTmQVrjCf+Ej0hLNl
         ZeevjB0drNUVzdgyTrCBU93z1lC3iSPFW8mpP+Kk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oKM4JfCuzp5p; Fri, 20 Aug 2021 07:57:27 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BC72C1280CAE;
        Fri, 20 Aug 2021 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629471447;
        bh=T8fM0mMRGQEJQ9wSjnQ4z65LLLqaO9J01HLIBiCTQuk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=efYeKvGOmb9BLn5/gUTYk7Uqzr9d7FhsQAJVFS50qmzQjZoHuYPMhtEsw+Rjz9F/9
         LZn3QfaPBp9CYGY8IC86zNe4NL9c+trOENn53Y1jvqONfq2dZhTmQVrjCf+Ej0hLNl
         ZeevjB0drNUVzdgyTrCBU93z1lC3iSPFW8mpP+Kk=
Message-ID: <0874a50b61cfaf7c817cab7344c49c1641c1fd10.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Date:   Fri, 20 Aug 2021 07:57:25 -0700
In-Reply-To: <20210820043339.2151352-1-jordy@pwning.systems>
References: <20210820043339.2151352-1-jordy@pwning.systems>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-20 at 06:33 +0200, Jordy Zomer wrote:
> As you can see there's an `atomic_inc` for each `memfd` that is
> opened in the `memfd_secret` syscall. If a local attacker succeeds to
> open 2^32 memfd's, the counter will wrap around to 0. This implies
> that you may hibernate again, even though there are still regions of
> this secret memory, thereby bypassing the security check.

This isn't a possible attack, is it?  secret memory is per process and
each process usually has an open fd limit of 1024.  That's not to say
we shouldn't have overflow protection just in case, but I think today
we don't have a problem.

James


