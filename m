Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595A63EEB20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhHQKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbhHQKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:42:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5AC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:42:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q2so24388603plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKzGDr7dHh04PS8/3LkKuZULv7SL/REMWSzAyqyZcGc=;
        b=KZ3KMcr+OsClYx/pT219VgLK7g9oxiV0PXu4qvgXBcRoLQhoVNquSDENzU292Kx8xM
         fuEkU9yQvcREVQTCckq11zvSfbuJzsVlC/bjYhw76+bZCc5W4tMm9xZD92pWmILFWi56
         33I+cRu5uOLkdvtAjZYUcajDvGH+g0noQouRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKzGDr7dHh04PS8/3LkKuZULv7SL/REMWSzAyqyZcGc=;
        b=m8iROoWreZ+t2cPr2CW0ySQkUspfUDmpQ2SCUqM1okYeRqMNOuMT30szOOZpJbJ3aM
         iScCW2GIR+z93JgWUCPjz31ljs/aWmxEqjtLDUixYuBPnV+YYUWBGsuYTveHQHuvoNS6
         oAjocA1vOpnApcOdFC//fsvQ+HfF2Diin1j0kOrleyQmM4PpCs1mddWsKDqS9jCCq5+T
         gLbOyQCFiNlS/Rxk8P9eTZY40CG0q+azrDSspaBeVyRSW0cCNw+TjyP90U0l6WWZIek5
         gxLYb0NGiSVWzzKwzlg/2B7qncHL2+FXk6kG1lPFP4k1hgMeeKTLpMFbi5v1kzSUjT29
         VSmw==
X-Gm-Message-State: AOAM533IgLTa4VS2ZMHa0LpfWzyQnsOaWNjoMHD52wOde7nXqGGxZW59
        s1SqaPmxXaX3dWiir7fFmv7RqA==
X-Google-Smtp-Source: ABdhPJwdRJZ8bXQbpXUY2ozAfD3dJ28JlqF3MQWzXZmnWNKmoNiR9m4nMY4TwRQv+ny3vOMxKzl5KQ==
X-Received: by 2002:a63:b09:: with SMTP id 9mr2946580pgl.53.1629196930291;
        Tue, 17 Aug 2021 03:42:10 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8aab:cb84:5fe8:99dd])
        by smtp.gmail.com with ESMTPSA id m5sm2962503pgn.70.2021.08.17.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:42:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 19:42:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 4/8] videobuf2: move cache_hints handling to allocators
Message-ID: <YRuSfAZiDNwEF0QP@google.com>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
 <20210727070517.443167-5-senozhatsky@chromium.org>
 <9997d302-effb-7026-6891-56426823fc25@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9997d302-effb-7026-6891-56426823fc25@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 10:11), Hans Verkuil wrote:
> On 27/07/2021 09:05, Sergey Senozhatsky wrote:
> > This moves cache hints handling from videobuf2 core down
> 
> from -> from the
> 
> > to allocators level, because allocators do the sync/flush
> 
> to allocators -> to the allocator's

Done, thanks.
