Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC8325898
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBYV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBYVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:25:56 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:25:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t25so4689374pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sv/cK48MuX+Y4npc2hqZNXEhNZvtvJw2LfqK3MM06hw=;
        b=JjVphRv+SRo+9fpJNqL523OmYibey9F250gnNPlbPjXQG+ztlA+oqhkY7O3/iTvwIY
         z7OZeQ60wF/hLu4metB+Oye1wic+BQ5HCq3VDirJcq4GrNDn0wJcnj/w+K3tNd9xXZAq
         ZG1kvBy5UHT+PqZPv4Pts6Sj0ro4boAdeNW+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sv/cK48MuX+Y4npc2hqZNXEhNZvtvJw2LfqK3MM06hw=;
        b=fK3Y7HLOkzoDJtAlloqAEe2ta82Oup9JCSezQ+64S4Ls9xwo1wbcE3kkZ/G5LBUELb
         cW1pPwpqEfL/BEjhFBxXXSofCL5V5Hn2aW3BvabyK2fg5d+EguGTHutmx49cmq2qgMZ0
         IWsGHSLOegCkmrJvY0o7zptIO8GzrTeHXZQ+UuzA9Ve6KejbyPz63iz3dm0ubwl24QlX
         RBamDqlxG4bQm/Epk2DMo26md3df8Yi1DPDP9fscawxn/Eq9MLaQnj9e1ctudij/u1yn
         uKsp9R2Xx6Pbb87N4U0Jk6732DAv1Z3x8KpWB58zX/g5G/zwLKKFLbYqBhpokBp16m6i
         gZGw==
X-Gm-Message-State: AOAM530IN38FBSzn3mFY95TFgT2y5lkdPsybhNU6yccSEa16jAerphs8
        kObLijxidla1e3gGSYhS+is9Wg==
X-Google-Smtp-Source: ABdhPJwv7cS34Qgav8vXf+fZl/tgCsqDCEsYnjKs8I0rA5qzN143Z9PhcknHelCjyylWDbqA4zAu2w==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr4584076pgh.405.1614288315130;
        Thu, 25 Feb 2021 13:25:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w3sm6812240pjt.4.2021.02.25.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:25:14 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        qemu-devel@nongnu.org, clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Date:   Thu, 25 Feb 2021 13:25:04 -0800
Message-Id: <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194258.4137998-1-nathan@kernel.org>
References: <20210211194258.4137998-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 12:42:58 -0700, Nathan Chancellor wrote:
> fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> which violates clang's CFI checking because fw_cfg_showrev()'s second
> parameter is 'struct attribute', whereas the ->show() member of 'struct
> kobj_structure' expects the second parameter to be of type 'struct
> kobj_attribute'.
> 
> $ cat /sys/firmware/qemu_fw_cfg/rev
> 3
> 
> [...]

Applied to kspp/cfi/cleanups, thanks!

[1/1] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
      https://git.kernel.org/kees/c/f5c4679d6c49

-- 
Kees Cook

