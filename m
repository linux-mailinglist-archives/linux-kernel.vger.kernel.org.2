Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184F636274E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbhDPR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbhDPR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:59:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:58:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14so9581391pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6foCwxVCDklL/5CLAd0ULHN1p3sHTS6VkpK8Ctm3DA=;
        b=fffoeN4GJycmqznQs0nwnRxEJQ95+4/yJHVb/0GPi192N1u88XITWkwJdOWgLUgVDr
         6W8gPp+n7VRT3NekSQsDBQZqHiDLZfk7PNVmu/QuR2CKMs5/WFtEM+qKoas9aOJO0jR6
         5B1j00mBHPLQ4ebYcNzx9jP2xp4EioNDtqC2XH9nA/z3Ily6ea7lELBG+aRLbOqcSHDv
         qp1Z7I9jFDPnJzkfoRboDsmJD99aiFbPjd2QRCKixaGP0N9QpOP5PHFMZ/zbhXB0u30s
         jdE5/0LJoLLSllhgR9A2rijh3PrhNLhHs3yiDaajnRRULZbNj7R3XDQNo+NcQcrwNK26
         uUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6foCwxVCDklL/5CLAd0ULHN1p3sHTS6VkpK8Ctm3DA=;
        b=FoJ+JU59yTJSKK5T/nW8yoZOsarl5allnYNBYjOaYlqoRO9RWV54E/cNEkCdOYJbo1
         ek4Xh6s3jbyW6wCCzL7lw7DthsWcngSCLlB+DphobW5IbCWBA8vMrWxUpurVaaRnyt4e
         fHEL7QGg863oDLAh4zsxk82wqv7KDucxhVXbw+bdX0OU2qOjxKaW8OtqJ4qOkbSNeKsP
         CydR94mpJed8LL3oumu+1sBKyyPkQC4Ht0ZvCTmGhDDVKlBlNDMPjZCyKlQCzIofnHwE
         R/ev+wSNwVLx+J1biXqsCxKVTGSdlAzOvKlGc+/VmAZHW0VRa98ZJZX1kBzkWXcI86Fd
         +Tjw==
X-Gm-Message-State: AOAM5326WPEzUZltA3U23bofi8QfmpHFmlf4q7Pb2GWX+SNypXLRF+Sq
        r37Qi5Pe0F+KfO0Q1qqBO5xB6g==
X-Google-Smtp-Source: ABdhPJxiAj8b5+5zgYtISRM9Z7KkIhSkLjEOGrG4RQsiofcjbDMLy3JIenak2OGgUCAw9n/ungf3yA==
X-Received: by 2002:a17:902:7589:b029:e8:c011:1f28 with SMTP id j9-20020a1709027589b02900e8c0111f28mr10610951pll.35.1618595935289;
        Fri, 16 Apr 2021 10:58:55 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o134sm5071499pfd.66.2021.04.16.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:58:54 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:58:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 0/8] remoteproc: imx_rproc: support i.MX7ULP/8MN/8MP
Message-ID: <20210416175852.GE1050209@xps15>
References: <1618493261-32606-1-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618493261-32606-1-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:27:33PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>  Typo fix 
>  patch 4: take state as a check condition
>  patch 5: move regmap lookup/attach to imx_rproc_detect_mode
>  patch 6: add imx_rproc_clk_enable for optional clk
>  patch 8: use switch/case in imx_rproc_detect_mode
> V3:
>  Add A-b tag for Patch 1/2
>  Fix the checkpatch warning for Patch 6,8
> 
> V2:
>  Patch 1/8, use fsl as vendor, typo fix
>  Because patchset [1] has v2 version, patch 5,6,7,8 are adapted that
>  change.
> 
> This patchset is to support i.MX7ULP/8MN/8MP, also includes a patch to
> parse fsl,auto-boot
>

Always specify what branch your work applies on and dependencies for it.  If
this was ready to go Bjorn would have a fun time figuring out it depends on your
other set[1].

I am done reviewing this pathset.

Mathieu 

[1] [PATCH V3 0/8] remoteproc: imx_rproc: support i.MX7ULP/8MN/8MP
 
> 
> Peng Fan (8):
>   dt-bindings: remoteproc: imx_rproc: add fsl,auto-boot property
>   dt-bindings: remoteproc: imx_rproc: add i.MX7ULP support
>   dt-bindings: remoteproc: imx_rproc: support i.MX8MN/P
>   remoteproc: imx_rproc: parse fsl,auto-boot
>   remoteproc: imx_rproc: initial support for mutilple start/stop method
>   remoteproc: imx_rproc: make clk optional
>   remoteproc: imx_rproc: support i.MX7ULP
>   remoteproc: imx_rproc: support i.MX8MN/P
> 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml         |  11 +-
>  drivers/remoteproc/imx_rproc.c                     | 206 +++++++++++++++++----
>  2 files changed, 179 insertions(+), 38 deletions(-)
> 
> -- 
> 2.7.4
> 
