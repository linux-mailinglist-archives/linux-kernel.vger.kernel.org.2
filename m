Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49B733C7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhCOU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:27:09 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44639 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCOU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:26:47 -0400
Received: by mail-pg1-f181.google.com with SMTP id t37so10345082pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lB7KxRggkVfDJSuMONFAu6mpVHiYdQgqGTTLTvKAJ+4=;
        b=sws8zPFM3eMnDUePWbH/rJ4PT/4m+knAwxa4av3Mz5vE8Sxkf04WpfIpQ+C5lgdUPc
         7NinjO3ZahcsvBrFa3N3Mv8IULTYszr8OVCc+k6cZAvcXeyWGg+iIgYTQRxqfW5UXOlC
         ynk0YN6vcXuJND+99kAyKq44NQlAzHXJ6A9rTnELHUXp3q7+KJQM5ZPOSrHbeZhLQDbq
         kEmz2H4Am6iUOACBrdz6wn69VpnUyJC68on3SCJ5H+I4TzcET3roF4senSaunnDtgqKF
         TBeEoXaMO58LnPVUWAeQgOxg4iXMge3Q6LT0ZVu1m0vXymBybjqqkn0hNXx/5vn1Yj0+
         92Mw==
X-Gm-Message-State: AOAM530DObUF0OIC25s8FUdt+CWezqZXj32WydDb/ziAt5LlzZrEq9zb
        dh4/eMPZcY6tLFzlwqziUKXl+X0hvrEiDg==
X-Google-Smtp-Source: ABdhPJyF+edLGfX2I+m9zmdUajBeD5M75vD7ggUYMN178WEr+KPz9iALZzk8CG34IYZPz+gv5wZWbg==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr781511pgm.304.1615840006969;
        Mon, 15 Mar 2021 13:26:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 25sm14358402pfh.199.2021.03.15.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:26:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4766240106; Mon, 15 Mar 2021 20:26:45 +0000 (UTC)
Date:   Mon, 15 Mar 2021 20:26:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umh: fix some spelling mistakes
Message-ID: <20210315202645.GG4332@42.do-not-panic.com>
References: <1615636139-4076-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615636139-4076-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:48:59AM -0800, zhouchuangao wrote:
> Fix some spelling mistakes, and modify the order of the parameter
> comments to be consistent with the order of the parameters passed
> to the function.
> 
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
