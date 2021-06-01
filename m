Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006F2397A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhFATTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:19:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:17:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g6so290172pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUUyD7O6JCMKmduUrqE7eyPTkSebjyeJhHYra7PUdnQ=;
        b=SqAi/ENxCFVkulIXSB1VhksmBc4c2GQFIdGxDv5fxL0vRsqmn3597gHONUKkFN8uvz
         7o0AjJNYkYcUY9Nkq/FyFXi3wMLho3nmGyINAYdIo8SstqzRzibZKDY8SC+h2o+t8PjE
         iTLyPHPt9OqeRrwzpIs3OVqNuWak12hOjbLhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUUyD7O6JCMKmduUrqE7eyPTkSebjyeJhHYra7PUdnQ=;
        b=V+kpXuCch5Is00/Dr956Tr1JlRBVKDmSxq8i+VNmJR71V7OTNHF7ETU0P0vbL4mcvC
         7gkbQ3GrtlN3qXruRou3WupiU3F5iCeHumTgSUzw1CWrmC6e0m3RjlD19QnUkHT/o5wK
         ILgktLkViWzG3VRlEAcoBgnu6a4rFT13tripigC71NRrxr7T6yFyZkbVRjZIUkq0XfM+
         YkdrWAJUxqfigEsPhfmemBU3x79NAKg//hbFfz+lIUlQ6JrIWxFMOA1a7Q80zfqAGp4H
         TnTR7EsRzx04+S8vbcojjaMcvSQ9dyipa69IwxBegL91/aMhtFVW60TS4wY9oqL37bcj
         4cvQ==
X-Gm-Message-State: AOAM532dQliQxsP6c8umhmi55Rz8yNFXZiXF0WuVJXU4JH6AzRJHXqc6
        3A2EVjq8KkC9uBmrHHyjoWtW0A==
X-Google-Smtp-Source: ABdhPJx2vPDHtoBxDH0gx5Co0TCaSf2x+OpD4SdyKicYlVxWXiF6AdzadtmK+ZuQ4ZSftK/fRLbVWQ==
X-Received: by 2002:a05:6a00:87:b029:2ea:d79:1d4e with SMTP id c7-20020a056a000087b02902ea0d791d4emr2818989pfj.59.1622575040865;
        Tue, 01 Jun 2021 12:17:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm7412037pjf.40.2021.06.01.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:17:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add Clang CFI section
Date:   Tue,  1 Jun 2021 12:17:14 -0700
Message-Id: <162257503133.1460666.16967231826334923768.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531210629.864888-1-nathan@kernel.org>
References: <20210531205405.67993-1-nathan@kernel.org> <20210531210629.864888-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 14:06:30 -0700, Nathan Chancellor wrote:
> Sami is the primary developer and Kees has been chauffeuring the patches
> to Linus so ensure they are always kept in the loop about proposed
> changes to these files. Add Nick and I as reviewers so we are CC'd as
> well.

Applied to for-next/clang/features, thanks!

[1/1] MAINTAINERS: Add Clang CFI section
      https://git.kernel.org/kees/c/3a40617ce088

-- 
Kees Cook

