Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822C3DC95C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhHACom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhHACok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 22:44:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61656C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 19:44:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t18so9370701qta.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5ecc/3b0c9DlP5gv+Twq7PKykLz+QwWDSWKrTcTwOY=;
        b=DJ4fqnmo+wk6enZYrC5wLyFeknzUsdGtntaumwN9szx9HM8ZClF58unPo8k9cd+WVG
         j6SvrMSbzAxHmqqcWN96hwjgPy/CmWdvPF/nr3qCtDV++/WeQEWWIDe8sCkqoCqqFRYr
         7ZUOYsdmC5jGYW0KiilCZspGZN0upgLOFTw1hTB9vawJaifDnOtBULqJpsyf4GlxbGyb
         AXKtpgXpb3vPntLRrMs26Sl4Bzbxwh4CtdGOo6xzHVdMk2w6vzv7+ZhmgsqdHwtr8L/M
         sc7JXdBNi2RdFqoPQT+YSwCaheMDp1I0RGGfpNCxR2cFWY6HdOa0zGmhRed7UICR4W4t
         Juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/5ecc/3b0c9DlP5gv+Twq7PKykLz+QwWDSWKrTcTwOY=;
        b=FYVZH+2XQwbPQeovRW5g7qEiEyclVaiy9l//hVme5w6jUULYAnxMZXtZCg3ch3jSCW
         6tMShhrfDIoV7vp0ldSMK8GGS+iPeZ4c9bczxP33O9IvecSR7HtFJT0IKPpx1Hbe+gb/
         oam86lgob++AOBLc68iLUacrr0zWH8P+CaGdlU0oobS4fNod55MmtviQR8fSMtPWILg+
         HmCDwRs2T45W48d75mzbc9jTp/7/oBVA5VT5AbaA2lDZkpNi7gLo1aT09erIhVZn7prq
         ztdZj5nyGk3ftf+ew/9N6ApY17p7f8WYqrfSYDx5Ho/tjo1ldaIC8Qh74ngJo5m5LLy9
         4tFQ==
X-Gm-Message-State: AOAM532yoJ3ZuVSkyInc1E0rB6iC+X6TIC7csBhUVStKZrJWtgn0Ad84
        eTouBT5TAsR8vlxGu+pkJeOlsNBRQLH2+FFe
X-Google-Smtp-Source: ABdhPJyHYfEwc/iHHbUaEE9pW29ukjZC4oODGCLzXRb7fb8xWbmuxwu3pCqJbWhKsCSLWBEQch6uUg==
X-Received: by 2002:ac8:734a:: with SMTP id q10mr8598774qtp.73.1627785870499;
        Sat, 31 Jul 2021 19:44:30 -0700 (PDT)
Received: from fedora (cpe-66-24-154-110.stny.res.rr.com. [66.24.154.110])
        by smtp.gmail.com with ESMTPSA id i4sm3376564qka.130.2021.07.31.19.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 19:44:30 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Sat, 31 Jul 2021 22:44:27 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Maurizio Lombardi <mlombard@redhat.com>, bp@alien8.de,
        tglx@linutronix.de, x86@kernel.org, pjones@redhat.com,
        konrad@kernel.org, george.kennedy@oracle.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YQYKixj1y4yey7zR@fedora>
References: <20210729135250.32212-1-mlombard@redhat.com>
 <YQMCFWYCSqNBRkX4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQMCFWYCSqNBRkX4@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Stuck it in linux-next and modified the commit message a bit. Thanks folks!
