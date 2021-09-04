Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF06400CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhIDTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234432AbhIDTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630781945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HXnj3Ws+84gl2qFHi/SPK9StWdk+HCAXfqUgYjBdwY=;
        b=ZFEEEwFKyFd32W/0Lewtfv5hz6Vyb3acgQR4WLgPQfEQKvll/tSag88t9uUDEJF+33SVdO
        Om3+wddAN2tMqO+EXOLC/+xYdsTshNz9LRsDvYE5s3YOv0e0GgYiipSk2flDFkipaS6fCH
        olfQnOlCIz9O45C66ci2MV/+JP24mkg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-INyRozzrMC2eCy7v_L_oYQ-1; Sat, 04 Sep 2021 14:59:04 -0400
X-MC-Unique: INyRozzrMC2eCy7v_L_oYQ-1
Received: by mail-qk1-f200.google.com with SMTP id k9-20020a05620a138900b003d59b580010so3914704qki.18
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HXnj3Ws+84gl2qFHi/SPK9StWdk+HCAXfqUgYjBdwY=;
        b=msELRvQY81Yq3WXhXY2E8Zu4T/NF4YVzzom8WLqjVeMp6uXwAMGl2PCBfqVnmPhKeG
         sJVzM+JHPFuDS5lty0lLpWL22EvwMETBFtEqdMUrLRMqZqW7BF2+2HhmrdsF12IgDICM
         59fP+deyTnMcCRWfH6hHnVW0CeaB/ZPeMPIdRBjaT5rMAoInqKXVyvwcNX0leSODVt0n
         tA+6j0N1QLQBim/KDcY5UqT4E++ZP30Jvbv9tnYec9FP+8cFy0y6C5hUdNTU3oYo1j61
         QrkFF8uVzdrkV0XSKBaHl2w+ADasuL+HEbOOtsjZUp54a18Gn2uVi3RWQ2xj3n50+S02
         pMTQ==
X-Gm-Message-State: AOAM532KZFrCh0K/UHe4umS0PYL4GuPWsRL1Fg/mnU19/xQpj1HlVf9D
        XSeYJa8R8jbv30rT4M/h7w+PWvS/Gr/OujWPqeX+mk1a0U/nBHDcUKaXzfXvPwDKmd01GuCwXwz
        f8YYLho+2Rsm4o5057c5Yh1eK
X-Received: by 2002:ac8:410e:: with SMTP id q14mr4454513qtl.377.1630781943985;
        Sat, 04 Sep 2021 11:59:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf4icXcwUek1bny772kVxIuGXTsJN1nK6r2zMqGs4J+pLSdseBaE9NMTfnXIOI9RfgvBHDRw==
X-Received: by 2002:ac8:410e:: with SMTP id q14mr4454500qtl.377.1630781943820;
        Sat, 04 Sep 2021 11:59:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id a9sm2259134qkk.82.2021.09.04.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:59:03 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:59:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] kbuild: factor out OBJECT_FILES_NON_STANDARD
 check into a macro
Message-ID: <20210904185900.exfebeute66m6z5s@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-5-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:55PM +0900, Masahiro Yamada wrote:
> The OBJECT_FILES_NON_STANDARD check is quite long.
> 
> Factor it out into a new macro, objtool-enabled, to not repeat it.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

