Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5F4448F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKCTcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhKCTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:32:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACEC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:29:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so5009587ott.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Y3d6E1SHGhXJn4Dvk0e2wYnCWALGfieMsoRHb/exO38=;
        b=Nlpj9VQg9J9S4S48NzQMds56GucWKbqxz1cKoQevhTMAyjBD6P8S6lpVHh7hCKXk8Z
         ubvCBQZIhFNRl75oWDVIjQU86EMiV5BhFO4w0FanEa2QNigig0oKKWExBqrHjOxyfbZD
         x4AaeV2afFFIW2IAMXWX4paB5XyrVb/Uj4cGO1tMbtbwEDT6wDMYYwljYiyX6/tslQUV
         8LEDllACSnwAVIXM1ijiEaFVt5mYJnLQ1pujeRWntcFSPR4ETsIliUxJFSTLCUzkcly1
         wzz2jUT2upPO6voi4OfJ1Xs0INnNeCOy3lE3XgpYnKijSpinp+ba1DsNqikIJMr0lLkr
         b6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Y3d6E1SHGhXJn4Dvk0e2wYnCWALGfieMsoRHb/exO38=;
        b=tB9RkP2FTKxEhS7bsSlYDKPhFMy6zUGLrGpthDVvRcoSMIfOD2ukG/euTG/N6cggcI
         GTToLxeTxHOkyZKEC/dpRYncEyCXTU0jGZJcvOZJzHOOGKLCi9/43Jw0uKfEVEV7V1st
         /jgyzSwFpC13P0Sih6VXvbS3OiUhFBGzJMxX1wuznO71X/PajmtqYauvsRh2yufgZJiP
         5Be2/IGuD3b0beDN3ojyQUdG18gcr7ZPobOF+gcZ1w0EvOlAiU62i8LotTaKWXk66Cxo
         ekxIhJaYiJlNHPWyRFCPbgQ1l9YuVPEktSMqqC4TcnUr7evLErixoGxCaFtkPylzNP5o
         EPsQ==
X-Gm-Message-State: AOAM531JsypxSbmyEWdPmgDXZZe8A0PrDMaHgK3fcd+eHM/OSpEohMW4
        TfRBlf/Tp2BAx6YdH/4XWXYNnA==
X-Google-Smtp-Source: ABdhPJyQzzTX1UgPm7SvPYQQRUJBgfitrA3qciUqirF/PD9KbBoSKsEuMnzT7nuMc4W5j3DiZHufsg==
X-Received: by 2002:a9d:70c4:: with SMTP id w4mr21718621otj.78.1635967766484;
        Wed, 03 Nov 2021 12:29:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z13sm748257otq.53.2021.11.03.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:29:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, Luis Chamberlain <mcgrof@kernel.org>,
        hch@lst.de, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
In-Reply-To: <20211103165843.1402142-1-mcgrof@kernel.org>
References: <20211103165843.1402142-1-mcgrof@kernel.org>
Subject: Re: [PATCH v3] nvdimm/btt: do not call del_gendisk() if not needed
Message-Id: <163596776548.186543.8354031131670153996.b4-ty@kernel.dk>
Date:   Wed, 03 Nov 2021 13:29:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 09:58:43 -0700, Luis Chamberlain wrote:
> del_gendisk() should not called if the disk has not been added. Fix this.
> 
> 

Applied, thanks!

[1/1] nvdimm/btt: do not call del_gendisk() if not needed
      commit: 3aefb5ee843fbe4789d03bb181e190d462df95e4

Best regards,
-- 
Jens Axboe


