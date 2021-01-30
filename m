Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFE3098C3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhA3XMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3XMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:12:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621AC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:11:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w14so9028528pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CYA0tZdulAeLRu+0Pp0MVAixuCTU0DdOiWTCQ56oUqM=;
        b=h1G+rtZyEkJgVGFy+4LV6fzraYMfMcLjxA/yM2w/uDee2p5RhlWmzh+LJDCdTEXXr3
         KBBhiXEUVhVcSi/SR7vhRaz9xFitaj8lt38FKYH0zq6Nhb78BTF5gWuXPctPssix2MeK
         W5fOuWK1jmPuwPvXaaklSWL6rw5vrSBh5m4uYMizecDziBS6d4Bwyo8A+04hdLpAbDEX
         G4s7M7YBb/27drL/413soNFjEIeLZBAchclHS11fIY1yvR+OjOk2AMc0NLqDuRH3zDuv
         atZKbggZBCKdxMELkX8YZlnzC7fa+i5tED052mdzluid5ARWI1zRiRhmsYshp9OKC4n1
         oKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CYA0tZdulAeLRu+0Pp0MVAixuCTU0DdOiWTCQ56oUqM=;
        b=kEO7H2jJkvccsgx5M0ouBybokJBhP/3NeIItWx/UNEPx/NWqSHMIP8Da8X2cXobvzV
         Hib6oOiQVjXkYTGIC2ugCh2TafPhKo6iYe/RjMCCaXrtGADatLupno19yEeLSfC5S/7m
         7G24sQbV5nK1xMObzQEihM2gR7Sca4y7809EoF843ISBE0nG5HJmMYwKkU+4C1jycTgE
         Ely2pCrSSnRzLEdIntXN9gf3oR83zDt3vhhwordEINxTquki8Tvm1HlkXb5xiWIAmJiF
         MJEg6EUJEovSE0GZwPuGU3bivI5epgRAZ0/4FXICll2pW4Y6k+7ELLRgL9XO8Megrb7/
         z+3Q==
X-Gm-Message-State: AOAM530h8ldaBg0FuA8FMrSvW9aS2tDGqQM9KXN5824UEvoXvbki+HNa
        qw7IjL/hZGXM9wtN9smPWAJPCpiJ/sE=
X-Google-Smtp-Source: ABdhPJx/iEHYhd/6O+deSAIOj4vqbt+OOVI+STFkXV+vrycpVvU54wAvuIoIjPdWMzvHHneYNQlcoQ==
X-Received: by 2002:a63:db54:: with SMTP id x20mr10273751pgi.200.1612048317710;
        Sat, 30 Jan 2021 15:11:57 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id lw17sm10090959pjb.11.2021.01.30.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:11:56 -0800 (PST)
Date:   Sun, 31 Jan 2021 08:11:55 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     geert@linux-m68k.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
Message-ID: <20210130231155.GD2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130230310.GC2002709@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Please disrecard the g@lianli.shorne-pla.net address in the mail
distribution list.  I must have it a incorrect button.

 -Stafford
