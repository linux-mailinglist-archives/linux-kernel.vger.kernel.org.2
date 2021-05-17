Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B27382A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhEQLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhEQLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:08:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E57C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:07:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f12so6705069ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T801vI3LxOUhucgqqtu/p+G3EjfDzfAqMYaB4S3ROjk=;
        b=kQyVf0rWbZwsBetvE0viHhCMcLvBuGe3ns/8Dj5GZQyyCNi70+HUzkaRrrcI0GAPou
         +cb2Qu/560qtgpMquXzzT9/lhkEVlAJqAGfJbqeco0eSvIhLNbD/tskLOhTcqemSlAgS
         34Y06h5LT43ehRCd1Tjqyf0vlGAHbvCX4EnO320mYMt24oXGgRMmJ1exUDbTUcdZrQBZ
         0QwRzWb1G2JPHkdnEBxwhqFuqGjr/bENRvFipGAmeW/Ah7mBZkSC05z1Ob0vEKw/87NP
         0lE5BL/kPR+1Mc8NIpaJjjGvBn5hAbnHFYe/SwDQUeFqGrP3scwLfLCQAMZfQGkDZh06
         zhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T801vI3LxOUhucgqqtu/p+G3EjfDzfAqMYaB4S3ROjk=;
        b=JEBwSdJhjTM1A+k97rk44BPnslYXOwKGX5EmROiHXkQXe/v7T10X03X/S0ehvTyJ6y
         jQTwfKDc+VETd3o0HBsHvjQCHRHNZPyXIRm0MxwLFn7oVj91zK8aHyCtW3jiQuLQ74Im
         d9n08e/2TVIxbAnc6AqQIS+Tdpf87vIVc4N7sNguPijFXjZWRJEdJ/YKJ/+8YHfVQBDg
         bIXZ9jDe4UtKB8vHOCdZmasJAi1BiWR2bmyHaObaqhAalqOM5TNDnoZAxacQuS8AwolX
         VNR4VvMH0rnKgtX1NQN8D1avx5R32L2qI7U9guSNeankpxiv1kxFbSr5HolSsIjuoD54
         tfYw==
X-Gm-Message-State: AOAM533ErXa8rRmBVnZC8zvi+vZZIems/5J+p9uBVtkR+KbrH99vXTDg
        Wq+GB79tg+wk5mLrgnwQ1c8SRRrGx9iVE8+W0WE=
X-Google-Smtp-Source: ABdhPJycDHrmY6TYNqNg+g+4uI2ZucTDhG9y1l6T26rCzALbjW6IatrSPREzJ87SunzaeilUYpvqfqDhcxCFPuXAlqw=
X-Received: by 2002:a2e:9ece:: with SMTP id h14mr49549410ljk.199.1621249625844;
 Mon, 17 May 2021 04:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210515180817.1751084-1-trix@redhat.com> <YKHPV4QAXmaWb6jJ@google.com>
In-Reply-To: <YKHPV4QAXmaWb6jJ@google.com>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Mon, 17 May 2021 20:06:56 +0900
Message-ID: <CAEcHRTqkCGstsdKr_z2dHpHADpJk6MMcZbuqnrw1gAzOAdUOqg@mail.gmail.com>
Subject: Re: [PATCH] percpu: initialize best_upa variable
To:     Dennis Zhou <dennis@kernel.org>
Cc:     trix@redhat.com, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:05 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> Can you also tell me what static analysis tool produced this? I'm just a
> little curious because this code hasn't changed in several years so I'd
> have expected some static analyzer to have caught this by now.
>

It's because uninitialize_var() was gone. It was introduced commit :
3f649ab728cda8("treewide: Remove uninitialized_var() usage")
