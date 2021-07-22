Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2D3D1E62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGVF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGVF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:58:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789ADC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:39:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b26so6897925lfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=;
        b=q+O9W4orIuaeNsabKDYJdenqrODw+azr8aXxE8WE2t7KCGz3LPADfZOo2iv+qZajZU
         3mTs4JhFZ9yvVkQfM5nJvuiuU5YrKEz0hBGhJilM3VJ1reXrDMyUXMNr6AinrMdENuGv
         spbj/Ata35GquWd4NMa3obOowGEMEtk403fiSKifQmdKTdiq4stKfLauUc8NleTNuXby
         TB3nlZ7v25wpDUlHM681a/X7YzSGIa8rfBTppXyBNTa/d8lpN8DUop4X3iq6KUM6oUIY
         zZu0VBxYlpQwIPsNblp1PleNS024h8kfY6Bgm/kDXY6OxiD/jJX/WGWKy7Fnyd+nMOZI
         oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=;
        b=Ldol3sWMYVGnp4VFBgkKKU6C8Vbxenzs30GswMixR6bdJCvoL0/6dJoEZWKXwxZwWc
         VmoQk4Q2TJAEHc0oY8cJqtyCHVC92Uq91S9MMm/VwyZgxZ9f+wdaTZMCHe9w8bdFpi7G
         LaEcnJ5VhjqJyF4tMQ3cJwSG7wWR+w5BIHuxFj46/e83jt7rWKY1S4re/5uQBxz+VojX
         oP7ngVVdGbD9YhxuyCUMk3KAH/MHRcPUsDArbLKCdSAuaQf14MNmP+eN7rc3faxqxYXL
         w9O9aY+96BnlqR9vOiOq7Pz2gszAkqNqm+jJ66I9LmZ1udB3wizrZNDQ7JXFzN2YacvK
         z5HA==
X-Gm-Message-State: AOAM533uTdAnBeSMwgzV2A2GGrXGd6N6SofQ9etILXmTSRLW7iH5f7Om
        xMWSvnJBhCb30j072Oss66tGHgNto+xPQaShn04=
X-Google-Smtp-Source: ABdhPJyaimF+6x0uFzkHCnnoPurYpyM0AuYABbk6VtsF1U5CXoVeBVq77XwfAVla3StRIrVa5nsdcxuX+nAJ9O7LfPI=
X-Received: by 2002:a19:c3d6:: with SMTP id t205mr27695615lff.622.1626935951887;
 Wed, 21 Jul 2021 23:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com> <YPkPLrBszwr1aiBe@infradead.org>
In-Reply-To: <YPkPLrBszwr1aiBe@infradead.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Jul 2021 23:39:00 -0700
Message-ID: <CACOAw_yvmK3hPA_Be=dR5MQapV2uu98coEnJhLZO3bt7Ef3Pcg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: change fiemap way in printing compression chunk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good point. I already made my second version of this.
We could revisit later to make it simple.

Thank you,

On Wed, Jul 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, any chane you could switch f2fs to use iomap_fiemap instead of
> the handrolled version?  Especially with the work from Eric to add
> iomap based direct I/O this should be much simpler now.
