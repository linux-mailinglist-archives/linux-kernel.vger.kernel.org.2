Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD942C0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhJMNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhJMNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:09:45 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32578C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Aiu6buoJWXPmir/QTtxcIiB4byIdTwxjnsxDXczZqc=; b=IpqMOimQRYersaA4xr+as7q37g
        IeN/DoXdXvXu7D2Z8YLkO0yQOfL9KXEbnzsOwlPJwkHE6kFLEoQXn5Dh6fxKKvI1QhtMzEAOXl87n
        bfCZlSRVvKkT44i303OFGo/oaEBNSMWn8yNqPLCrYZtDJ4Ziy9ifvnt3CUhGXZJMwZWGw5AvBRl2j
        YFslwyKzQHlBj6p4qCpjkkKUMfdvogikqldd+ZFk6K9plTa26us7lTdZc9C8BSy31Ye9aUfxw+lbI
        dYoViTEJtY4L2X9GVitCDtFlB2qm48Hze2/yo+oDLst1c9mmqsIwCkTlXMeNU5pjLF9yxFJfqb0Oy
        xoCPi70w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madyv-00Gm6t-9N; Wed, 13 Oct 2021 13:07:41 +0000
Date:   Wed, 13 Oct 2021 06:07:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: change to print useful messages from
 elf_validity_check()
Message-ID: <YWbaHekFwaEaNuJr@bombadil.infradead.org>
References: <20211004200625.378439-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004200625.378439-1-skhan@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:06:25PM -0600, Shuah Khan wrote:
> elf_validity_check() checks ELF headers for errors and ELF Spec.
> compliance and if any of them fail it returns -ENOEXEC from all of
> these error paths. Almost all of them don't print any messages.
> 
> When elf_validity_check() returns an error, load_module() prints an
> error message without error code. It is hard to determine why the
> module ELF structure is invalid, even if load_module() prints the
> error code which is -ENOEXEC in all of these cases.
> 
> Change to print useful error messages from elf_validity_check() to
> clearly say what went wrong and why the ELF validity checks failed.
> 
> Remove the load_module() error message which is no longer needed.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks! Queued for modules-next [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
