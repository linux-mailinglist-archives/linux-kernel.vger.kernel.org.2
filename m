Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE2405FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbhIIWvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhIIWvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:51:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE23C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 15:50:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g192-20020a25dbc9000000b0059bd2958c8aso4462867ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cOv81gwC9dNLZhqvyYQGhAuBKrBFj15moK9/frQLFMU=;
        b=GDxCPvAruNETvNqoBKUPqU9jy05fk1bp3PWMM3Ljuxl6vVxIF4AQAnIMwpKJNL0LlE
         edukWYZi/ADH6MMDY1rpxPA0nFuzcN0O/HhhCXj5JeU2H8usrlcbcEFiAAfPU/0G4lfE
         BqdZklQWBrxjTrfzfMgUdg0CoJ47EV2STC35HOBP3LIHVQaWtPaLBBKDGmHDa8hR/5QO
         gOl3G+o+CYR9ywt8QyMzByFXdPCGHdpf98uU3VYW+XYTS2L4GkQSRVa3V8Li/NYa3xWq
         ZvC7SBNBEbzrHUqY4YkInYgBnpGF2UpsarBT8r1XeZOU/GZOK7fmEP/cUJt6qsJwBaFW
         s2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cOv81gwC9dNLZhqvyYQGhAuBKrBFj15moK9/frQLFMU=;
        b=AgUzpkZQi5NGnVW5AjbT7eDUihfxAE9tFWe8A5VAzxZXYuhElYy5DenGan5vZQHSSk
         GVTI3b7uyy/E+uIGralHjIW4BnCxBp0RllzKd9Yezys6fGsKOvE48IbeBkL1maIrKply
         7hqjwvUkuwL5zRG4XiRjmvAG02Van+hRjKLxMMMlgch6pw1ckvIkgL0lUnjS6PycoVoP
         YOeySRzVBdYk70Sbp9PFgNm/vtWAOqEEOLqBKAFT04EJ/7JTNw9P0aMgsSxdT/SI5fxj
         Rn14WJi4vuLWqzKSpHt8EmzKFimUYL8bA4UNHz4BwHP0ZoH6Up0z8nIL1ANcWnXE60Q0
         ntJA==
X-Gm-Message-State: AOAM530n/E6HeVqDEO7cp0ieP4hloeeLqkFFDUJ2kynLnCCCql6G5pUm
        pNdpcm93F5Ly13482K23PPxiFeYeaLG5eoJD7kI=
X-Google-Smtp-Source: ABdhPJwLFHXNgRlAL2YzqDpSi9C+NWVrDLnaDnOcMPOieXeSDgUkK6PEfuqwIliiam/Ydm/pGfidEk5vldeGCbWGJz0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9a5f:693a:26cc:1fd6])
 (user=ndesaulniers job=sendgmr) by 2002:a25:664c:: with SMTP id
 z12mr7299807ybm.62.1631227837092; Thu, 09 Sep 2021 15:50:37 -0700 (PDT)
Date:   Thu,  9 Sep 2021 15:50:35 -0700
In-Reply-To: <20210909182525.372ee687@canb.auug.org.au>
Message-Id: <20210909225035.3990728-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210909182525.372ee687@canb.auug.org.au>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: linux-next: build failure while building Linus' tree
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     sfr@canb.auug.org.au
Cc:     axboe@kernel.dk, josef@toxicpanda.com, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rasmus

This was introduced in
commit f0907827a8a91 ("compiler.h: enable builtin overflow checkers and add
fallback code")
which added division using the `/` operator, which is problematic when checking
for overflows of 64b operands on 32b targets.

We'll probably need helpers from linux/math64.h and some combination of
__builtin_choose_expr/__builtin_types_compatible_p.

That will help us fix another compiler bug for older clang releases, too.
https://github.com/ClangBuiltLinux/linux/issues/1438.
