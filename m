Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B774254D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhJGNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbhJGNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:55:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601BC061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:53:33 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b16so6146331qtt.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4D+8fIGQfZQRL6O4ilxte9acbk0yTFGz3kGbSFrFrjQ=;
        b=S4TlnmGf7fi2da0VpIauoGdtpAJV+eZPvZcJOHWpH+jfyiZLWL2u6prLmVlXzTNHTS
         3NWVgVksHlLSni+Zh0aCeVJOcRAnwic8Wj34OMyRQlGjq6bM/jPybQuzRrsgOkVGzayG
         XqrRZYYyKo1yWqnLu7VhI8h9lK1JpBXbA5hWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4D+8fIGQfZQRL6O4ilxte9acbk0yTFGz3kGbSFrFrjQ=;
        b=4147wnqe1y5QGzql4b7RE/U7EbsDIY/JDoH3oCwfXjqAQntaD5ni0GmtbtYF54idhQ
         gCAfaOYN9tRl2hz1nZaDFWAWGQ12tf490xEP9muxLQHO5Royn7xI3tAeFlU5tY9seXzP
         q29gPErtU6NPN7O2aYxzT7hX3odwD6E6pFQAvFWlpQoj/bYreex2/tWx0Qzw9dyehjVc
         LshY09IZPNHR4onOA6yVlO6aGdKpPX/W3VGlORVbh7PeAmosafH/s/L5Ix2XVgYBdktJ
         p4sSNJMBwWujdbEb95i83QEBA2RTKt2jdSEIqeUsFfEhYHvjPjDm7OpTzmSxOa/jj79Y
         5Slw==
X-Gm-Message-State: AOAM5318gePZeZomIetIs21y+LV+aAtnRvFkbPYp+S85nAV+k/HKWZql
        Fe2KcC3UEVbgz90VPbEfHEl3+f6Mzy+M1Q==
X-Google-Smtp-Source: ABdhPJwcHrr57LfvIwqtKNYhUgrL8xhLV52BLnYDjYiyfPL9kN5rmd66eD+Gnx3mCFC6OBQwVa0b5g==
X-Received: by 2002:ac8:24e:: with SMTP id o14mr4893747qtg.183.1633614812739;
        Thu, 07 Oct 2021 06:53:32 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id s203sm140319qke.21.2021.10.07.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:53:32 -0700 (PDT)
Date:   Thu, 7 Oct 2021 09:53:31 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Prefer lore.kernel.org and explain Link: tags
 better
Message-ID: <20211007135331.3gi33cltdybljq54@meerkat.local>
References: <cover.1633593385.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1633593385.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 10:04:59AM +0200, Thorsten Leemhuis wrote:
> v2:
> - slightly reword after suggestiones from Konstantin (thx!)
> - make this a patch series with an preparatory patch that does
>   s!lkml.kernel.org!lore.kernel.org! everywhere in the docs

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Thanks,
-K
