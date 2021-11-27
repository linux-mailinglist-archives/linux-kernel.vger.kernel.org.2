Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44179460017
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355692AbhK0QN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 11:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355578AbhK0QLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 11:11:24 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A4C06175A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 08:08:09 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i6so12282938ila.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=TFDhWEFT78dShTBpt1jDJLJmhPVNkWFwTNPna2oPguo=;
        b=GK/pZ5QTqcJI2AxmD/RUUIKx9wmTTFRfN/aYljxGFwdgArDuR553KbgYli8X/J7s5i
         +wNOvaftc/CrRwLhCAUj4ubCTN2BBVKoObvsSij2ix+N0SrJfumV9hhmjbTPYigXsSAr
         VU4iEukug05xaVGCa8Ze+hOPy6on7KEGPqHJHenr0c9qSQ5PFMu7DHkQGAMHa4VrQiTd
         p3NgWEBDtq19h3cZKry0rBlxkn5vZxlS1svJ2fnAOj+GHnFSslOSw7kZwX909VmX3Z6l
         0gS+z8r+vdlNJ5D6IpW/qQSIlk8jz1WlSFhK1WTCA2ARxO1dY27C1Bfj13A0HgxwfWcq
         px3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=TFDhWEFT78dShTBpt1jDJLJmhPVNkWFwTNPna2oPguo=;
        b=oDWKkzHJ6USfopGRb0HTE8uUNIghkZhOJmTNjq7RI/1bBUZjg+G8Y9+K3rNkNL5rwQ
         sendqGN6C88uWZd8ZeyUt4TAysTO9gO/36y8EouOKnSO/X5tTYqTmdv/I6aSpsZhrFhO
         bPsaWi1xckM/qaV0FO/N7Rn2NsRky2GKkuADBYjSpHh2Q7QZW4Xe8BgfoHLXYsR+G1y5
         /umdoVMf75CVvV2LCSGzLO5DjYa4beqIte+Ecpn9OOjcFif/dynUvhJtGTPjsmOQVrG7
         DjcEbWh22r2uSb0jRm62ppbQEzU83faX/oYQuFymKeFO75zuqF0yNdUv/fY4RZpjEVsO
         ADYg==
X-Gm-Message-State: AOAM533zlkj4N/UbE/3X2jhSH5ujY9w358fCrcsrxsfH2rUm4qvWHmtL
        NHxvpYjqyZ752rZTSNyd31huyEDpiQP2ih1e
X-Google-Smtp-Source: ABdhPJxTUvu/yog86X7sXAzysQZ0PRii7gNhy4t3Bzsc/U+kNjfBWOSEtkiCPuZjmyw37LRUBi6MEg==
X-Received: by 2002:a05:6e02:1a8b:: with SMTP id k11mr28610456ilv.52.1638029289097;
        Sat, 27 Nov 2021 08:08:09 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d12sm5749981ilg.85.2021.11.27.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 08:08:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211126230652.1175636-1-colin.i.king@gmail.com>
References: <20211126230652.1175636-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] block: Remove redundant initialization of variable ret
Message-Id: <163802928837.10246.12448995088826384297.b4-ty@kernel.dk>
Date:   Sat, 27 Nov 2021 09:08:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 23:06:52 +0000, Colin Ian King wrote:
> The variable ret is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> 

Applied, thanks!

[1/1] block: Remove redundant initialization of variable ret
      commit: a77f46727daa3febf99663ab1a43c86cf3c2b957

Best regards,
-- 
Jens Axboe


