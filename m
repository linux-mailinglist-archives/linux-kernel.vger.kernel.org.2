Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E603A8B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFOV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFOV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:59:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A446AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:57:37 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t40so171356oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJ68jEOpuKbwPmRBXZsD218+2YyKdOc58eK+Zob4jtE=;
        b=sSrAx1gK+umcERhNw6FVQB9nmF/D8HEu1PmrO3+WQxDAJYyoyAXkU6ZooNYw/wVtc7
         uS+fKIl1FRSBCLWIVHHbRxhqEz4sUMxPy8K/pVtJ4afuWWadqN5QztOKSjmybrH9YOYc
         G1dsbyRXE5dQn4Ta9MXBZG/l2GJU2Y2uCwjL4dxYvPrfdukXdcregfkKG3QP39jEXQvb
         aVPeRSfPCiK4cZRXAmyPY/pAf8PbitTnd4Av8C3h0I41qWWj3HhJB/x69USYyT2ZHxpp
         /nGzc+dqMfcLP5XgOGJwXG9QrsaArQlfIID0EHQy41atFc6WTzzGsoYPcKruS9lBJm45
         HN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJ68jEOpuKbwPmRBXZsD218+2YyKdOc58eK+Zob4jtE=;
        b=XhMxfIx6trUMVM6Yz/TIbhXpUYKBnLpKTw2IF5SnNgG8mR28vhM9Z8xMgVosZt1odg
         8JndZcBtQFT651uqe0Y0dMKoyyF2GuvfmRIQpu2b+aOGymlgfdpCsXsQ7eVr9NB+ruGW
         QMsP6teavYUJXAUq5/5X2JDmLIxPQczkNwT9HyuZ9N8ltNEC4rxqYMnxaEZ3HAnepbqx
         vQwdSCRJWvCv7YdzLUngevSTQrZKapMHFNSwZqya+yahvY9HHvSmP+q692YIV7E+B6In
         08cSG8FmDAXVo7d5MNDGe13hmKp08r130Golor8ecllAuSHyb/7YRMGnwNfnAoyBzsM3
         NfvA==
X-Gm-Message-State: AOAM531qgLKO7OvyJAW03XnKhwOBRC7pEUG3v0ptkv3xrWu1T05rRTzq
        6BQOTSYt7GwlFC1Nm5a+Stb3h0KZ8ngsHQ==
X-Google-Smtp-Source: ABdhPJy7jg90sjXl0YaBshGHsHTC0xz41iTkdqrbBIZMvbZbbeZv3mWWwBHd1KOj23u1LBLFaDK3dA==
X-Received: by 2002:aca:618a:: with SMTP id v132mr4670614oib.144.1623794256966;
        Tue, 15 Jun 2021 14:57:36 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d20sm53842otq.62.2021.06.15.14.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:57:36 -0700 (PDT)
Subject: Re: cleanup ubd gendisk registration
To:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210614060759.3965724-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <920a6605-f920-ef10-55a0-733219abee6b@kernel.dk>
Date:   Tue, 15 Jun 2021 15:57:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614060759.3965724-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 12:07 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series sits on top of Jens' for-5.14/block branch and tries to
> convert ubd to the new gendisk and request_queue registration helpers.
> As part of that I found that the ide emulation code currently registers
> two gendisk for a request_queue which leads to a bunch of problems we've
> avoided in other drivers (only the mmc subsystem has a similar issue).
> Given that the legacy IDE driver isn't practically used any more and
> modern userspace doesn't hard code specific block drivers, so I think
> we can just drop it.  Let me know if this is ok.

Applied, thanks.

-- 
Jens Axboe

