Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5842F878
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhJOQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhJOQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:43:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD412C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:41:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so42817697lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yssoiv2eaRCJkjBecpi/apKs28zaLnx29ngWyMoxLfk=;
        b=djLRfVN1uG4vsB9t2QUGHyR6EDZFXOseZ4S+5/CZpZWJWM2vs/kqbk7/X6Fbiq+NWm
         ruhcNHhvvxQp3iK5yyF75NdUIuVeSF6LfhRotrZyrLTQpIIyfvWte+mv+2ek/nlugl1j
         82a+9sAM1shW3jwfKCzMYsFDHHYJJss4v+v4mPTaIiagv6EaD/0d3PbIhUMIyJzwipUx
         1ghUV6b5NwZ1FknncHv6zkWXikU0tbi8iK0Mvdp19ZTaoXrN/tSWGQZycTMDH2ZOjCbY
         66jlXvn/ioM11sSYHQfHC1xgKjKEKr+Xt/QqLkKOWjNUXWMv1rS6kUcM2+ydl07FjW3W
         XUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yssoiv2eaRCJkjBecpi/apKs28zaLnx29ngWyMoxLfk=;
        b=rxm0Ktcby7WNSMukSPCzokLkR7u9jW7szM6WsfsqA0Z9RFg3YqsIVXw7U/AcBnJogJ
         ORuuJyk5Wv9eQ5Wl3AQ8H0GApbUWKEgIUlXYLA1QhUfr5BgwP8x0M9h96pnFZOK6xiUe
         n45TbywpFOrjtL79Y143l4WSQjw147f3zZbwB74R74EBX1jLYNzVksWBlPFGNdaSXinQ
         Yo2CoFJ3kIPwEibEVMORQwQVIc4yBYrx3LXBQCjQhNOGWL4wNdc6ck11VGQ/zqMH7353
         XoL1xhxFh6qkd6WfVHyzmbSH10WCH7wXVSKRP+7RAZ+W16ntm0+K62vanb/IvyCHunm1
         niHw==
X-Gm-Message-State: AOAM5303PntU1z9z7z//taCjhPzh/Q7ePKkvcumCxSwZSa/3tuSEXJAw
        mB3ByIRSiqs/3xkF+/QW3b5JGTnDLNW0chggbVg=
X-Google-Smtp-Source: ABdhPJxTvkrnA0V97knhJ/NuQbTpppl8PdUUjcgH5uM75a++zQ2ZMcdGJzYqGJApHliPiwv3QIQ6J7/D9ZEWi6ETRcM=
X-Received: by 2002:a05:651c:17a5:: with SMTP id bn37mr13755001ljb.514.1634316094314;
 Fri, 15 Oct 2021 09:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1c03:0:0:0:0:0 with HTTP; Fri, 15 Oct 2021 09:41:33
 -0700 (PDT)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <rogerpakayi@gmail.com>
Date:   Fri, 15 Oct 2021 09:41:33 -0700
Message-ID: <CAL0uRZAF_Enmvzt48U4FYQVnhoASwQ9mwDoCnBrR5Dz4F8gn2w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi how are you doing today ? You receive my message i send to you?
