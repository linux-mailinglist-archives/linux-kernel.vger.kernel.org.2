Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E13828AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhEQJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbhEQJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:46:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:45:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so8200038ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLt22fpVUCej9eNuT5hv0QxiM34SFiWK3fjhN9lD/gI=;
        b=lappLtdOg/L4pCgHrMqswzXGf0hRPhbNu+a08oA6wQWPqtrlzYv/nmw6BToVjmqDUt
         p+F79aPLyNUTL4YvDd2wyj0dQ4JtpsP3Tii9LVwAZkt3VsqJQGahRMtzAkDaWTXiu0wQ
         bM/X3i+up+eyXjFr+Gj/VQJUlL+8EEGpkYmpiCtkx0rX2StYXMY5BXNLKWGGN9QX0VKF
         9bw+saDgnsjSj/XnAFmtbpXUOPNtIVj3KAGVaAqoR8O8WsRwbVaqpiVbgGKrbLryJMB+
         oE1AILkiue64dOo1NCtlDq5g6aurzXOdldX1l7jqrYlJ4ekkH31UaokUEbo49RjDVvXz
         ipwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLt22fpVUCej9eNuT5hv0QxiM34SFiWK3fjhN9lD/gI=;
        b=lO4cqkLzADPvol/eECXx5AaqFcceN8uog/6n3fBKlUjR4DGcv9d8sFKQjo3JPumgMT
         RvWe5iBU0eRM5/rL4hoSy8Bq3xd5NcyCG7fCGGCh8XxWhSnEPMRzrhET1leNjP3Y+8pL
         9FJX/SHUzZTS+yN5ngFzjfZJZc9IYP6rvSh4AxvcMCGLGClVRQjVYogEJ8or4Sri9XgY
         cULdO+7/eLJN9yC2s/WeJeffvbxY8y7U0zoCkbeBxKyzj2e3D/k1l8qaX6ng6kLbCVKd
         FuOIKxa+aTnZbGd/RGVOOnk2g4s+On7UEkWaP1+KFVnYtm3xk+tAzaBn3JdI8Dejb4gK
         ZIlw==
X-Gm-Message-State: AOAM5318LCjRlctBMQvYbhqLFxFujd38DvhM8AYygfSUabicOSES9yZZ
        Pq1rpqZd1Y677GuDZoBxBp0hmg==
X-Google-Smtp-Source: ABdhPJzPqScsP9bEPzkGLGjpbkNEjEMLd68G7qVFrs22hfroHJDyZFhP1cQLRaLVjBUl1Pp8u7N4bg==
X-Received: by 2002:a17:906:b259:: with SMTP id ce25mr12673075ejb.245.1621244710004;
        Mon, 17 May 2021 02:45:10 -0700 (PDT)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id s2sm10657481edu.89.2021.05.17.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:45:09 -0700 (PDT)
Date:   Mon, 17 May 2021 11:45:08 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/34] net: netronome: nfp: Fix wrong function name in
 comments
Message-ID: <20210517094507.GA17134@netronome.com>
References: <1621076039-53986-1-git-send-email-shenyang39@huawei.com>
 <1621076039-53986-18-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621076039-53986-18-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 06:53:42PM +0800, Yang Shen wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/ethernet/netronome/nfp/ccm_mbox.c:52: warning: expecting prototype for struct nfp_ccm_mbox_skb_cb. Prototype was for struct nfp_ccm_mbox_cmsg_cb instead
>  drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c:35: warning: expecting prototype for struct nfp_tun_pre_run_rule. Prototype was for struct nfp_tun_pre_tun_rule instead
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c:38: warning: expecting prototype for NFFW_INFO_VERSION history(). Prototype was for NFFW_INFO_VERSION_CURRENT() instead
> 
> Cc: Simon Horman <simon.horman@netronome.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

Thanks,

looks good to me.

Signed-off-by: Simon Horman <simon.horman@netronome.com>
