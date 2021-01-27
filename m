Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24F305E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhA0OpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhA0Ooc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:44:32 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C964C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:43:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t63so1901529qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QhcLut2oKrkGytsjohtG4P+eTmc8xAGWoRNoftfFJfo=;
        b=mZh3/n96wmnfLE3LZWvprNxZq35hZ/KukfZVbsuR6aTVAao7wtAw9N+eYqKLZFOsAK
         xo6NwcWr3fLr+L1FbgF64WVRWYW90Z38Yu841s8wsIU09ORgNqMS8bx1oIas1azZ+ZSA
         UPom6JRqBnNNi6WxbdGsSNTonv/MP4ZfZdkpUv0kZNQUrZS3sIpK6yeJ4X2Z/b4kphCz
         2S8ynmHYSsnx4dWWs6U4NcGeBjB7rGBqtVStxCwtN6LjmFSpBeVv8PuFqtYBMGrdtKBL
         ZkXUT1OSaDFIY+bP61kPm+wRZQxke0vqR8FJ6fBW7ECQyto5lSvsSZvfhkkulAq5Tut+
         mUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QhcLut2oKrkGytsjohtG4P+eTmc8xAGWoRNoftfFJfo=;
        b=F8GjhNz1dzFbXKAlx7YsmP+NQrHmVgvUcQLkrLVdxAwPgePR+0baTnt3gfQ9GvVIVZ
         HnA2VXcD60S+DBVgjXSxN8ORKGbwzHyi+IhhjMWyqraqFmlnKQMVfblC2NvoDlvipnNO
         l0ERaiWgPxS8Wr3RaiGyrqN9dfCW9BhzeGgH+0ekNyj26tksosV623aeksgS/Slp+waf
         vPYhA5hpXVN6VqUjRDhObFAX0dfozEgly+ofMfkTpbH0BO/MhflPB2TWgTaSBGg4QAMc
         uIr6mR3RmJ4qJK58FtwwViMQQyfOcroTcsfrShsZEZiSWroAKnZj7aP7V+bpzCoo9SCD
         wYnQ==
X-Gm-Message-State: AOAM5311gr8y1pMWiG4epjLKFZ3eq2wu9MDNPRg+B2jKvLAtmLc6ctjg
        s+clxuVdhkKwOt6zQGtmtpWbwUZ1P3A=
X-Google-Smtp-Source: ABdhPJxKIGwAYbx3pELGdsx3AmIwPH9v1nQ04y45b8Uo9TM0gNrjfBpEzzokw2Ywa9qdlzo9f9ol6Q==
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr10669154qkg.65.1611758631319;
        Wed, 27 Jan 2021 06:43:51 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id g186sm1312410qke.0.2021.01.27.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:43:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jan 2021 09:43:49 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use %s instead of function name
Message-ID: <YBF8JSgcAByDk0LS@slm.duckdns.org>
References: <1611389040-5014-1-git-send-email-stephenzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611389040-5014-1-git-send-email-stephenzhangzsd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 04:04:00PM +0800, Stephen Zhang wrote:
> It is better to replace the function name with %s, in case the function
> name changes.
> 
> Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>

Applied to wq/for-5.12.

Thanks.

-- 
tejun
