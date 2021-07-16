Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975733CBCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhGPUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:01:55 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37824 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:01:54 -0400
Received: by mail-pj1-f47.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso9499146pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJ6jfAMh7xy/5MHnHA2PMsUYV05QHhVngFxQKB/PKEw=;
        b=cc8z6chazccHvIKhh2I3uSYbqoQJuApCePmCmyHdsNwfMFC8D3czCxkVJA6zEtSnOa
         DSmKb1I2CuZcrNw9aAAHZ45dhPDvrm17chP5RWcELhkMBoD0PqT9B3ovNt3FoKP6Amrv
         TSBJKVxnKIy2YnbTAoIEr0x/edM4AS4YVUO21eHhLGGMSdhAcWbw/wLay62uHy8G0I1U
         pYzPnRcYnee/ZrBRfoV/5yZu5F+/iE5tD/Xa1M8eRQi0tG/kZ0GwzBRxfPfr/zX83qsg
         V0YQn8/HyC8vO1jvUMl0+H29un3qMXDWDZx7zexO3Sf2j9q/ui01GDSvS8FykBNydgH4
         FL3Q==
X-Gm-Message-State: AOAM531fX11ogsnAOqIHGRaF0d2XkxFtjMSCoHQIfWGE9wRHSDXEVAWA
        fQ5Os30Msa42soLZycAGhj0=
X-Google-Smtp-Source: ABdhPJx6v1N/fet1CrbEGF55YR3/OrrIOAQm9j4YaI0AlAdyVFq8zGdktVWI//bHImCfzWZdYdqUlA==
X-Received: by 2002:a17:90a:5306:: with SMTP id x6mr11289685pjh.59.1626465538928;
        Fri, 16 Jul 2021 12:58:58 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id b21sm10943285pfo.64.2021.07.16.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:58:58 -0700 (PDT)
Date:   Fri, 16 Jul 2021 12:58:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ming Lei <ming.lei@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] firmware: fix use-after-free in _request_firmware()
Message-ID: <20210716195855.i5pfpz2xsu3ql44b@garbanzo>
References: <20210713024942.2881-1-thunder.leizhen@huawei.com>
 <20210716195628.a2pz73hdudrsf7vu@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716195628.a2pz73hdudrsf7vu@garbanzo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:56:32PM -0700, Luis Chamberlain wrote:
> Can you resend a v2 patch describing how ...

While at it, can you also change the subject of the patch
to be more specific and clear, perhaps something like:

firmware: fix theoretical UAF race with firmware cache and resume

  Luis
