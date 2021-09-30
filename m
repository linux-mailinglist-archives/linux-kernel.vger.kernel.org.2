Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D055F41D220
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbhI3EQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhI3EQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:16:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:14:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so19806680lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sO0x8NIMxwP46ESNIv2xpVjBhysVETzW2chJwSBzRwU=;
        b=kOlfRcYl1zI/gm4F+aW0myQT/iEast95dJACdmRQDm/TcEZVdiddb+ZHtb4dTO1PP1
         FPwpfswU1f7ejYcpmDCbVjc3jtKwFKzmTJ8b8B7Yz7eH+YZRqoxQY2hCaSBZB/+ckvcn
         7xuIQoniNOBP/999GVUyrZiQk3WNHJk8LWkH7fBSRQZ03VZPi1HUOTkdAY7RCw36g9ul
         gYt0MDwcyjJ6uERhtAsR6nQEwcz8E9RQUcCb78SK+1EdGOGHxVV/4ULDNYo8HMx5K0YZ
         KVlXXRC1RSK3czc3oJTVRvrFJyEpR5E/tzkQHZr7sZLGOe6X1hbk2T8JpZQdRuTEdptA
         5pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sO0x8NIMxwP46ESNIv2xpVjBhysVETzW2chJwSBzRwU=;
        b=LaJerhXVfbEjPrREiXR39rnh4r+SUDYUQp/AJquTVLrG9G+YdDhZNHo7hpIJMJJxks
         IIaboVUuTW/WYnh5dYwnyhJud1bPM4VsTOcFp/9m5K+TmkJNj+08eeFyyhjhkY5zThSk
         V9B4pp+vdIt0whKjSKbZWArXa+u+K3iOfETWNSJ7p9xDhVuUGp4ihPoyrvKpeUkIynb/
         XviJnq+bUQiRmIanBsYNa6CePCuxu4zX2gctKlQjZ6ANW9Acms0aEwUY34W0gU8hw/xt
         m2tgB4JGa4tN6jNrci212WZVfdLDThPXJOGRFPiIYHlfgXxDtOCgWfAtpjC8QNOiNU04
         +eqQ==
X-Gm-Message-State: AOAM532yrc5r0keHS6P4x97pAmrS/w/878ogN5B7OvWoyqqH8Ywh+5cW
        T93TBz4i9LCareq+4/6TtwzsURL6r+qqyZkAbj1le9RpyjM=
X-Google-Smtp-Source: ABdhPJxT+3WPkEoiGoMMpArF5WTfk12bq/AM8QQ4F1c4ZuLJ3bH+idLVa4cTe2g4hOcjOFRhdOfeMfagydqhPQG7CPM=
X-Received: by 2002:a05:6512:b08:: with SMTP id w8mr3509908lfu.505.1632975264674;
 Wed, 29 Sep 2021 21:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com> <YVSgplQLvPg1490d@arm.com>
In-Reply-To: <YVSgplQLvPg1490d@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Sep 2021 00:13:47 -0400
Message-ID: <CA+CK2bBJqxq9Kwei-na_mgObMe0WF=im00YtPe10sp3g2+c79Q@mail.gmail.com>
Subject: Re: [PATCH v17 00/15] arm64: MMU enabled kexec relocation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, I'm fine with this series. I think the only concern raised by
> James and not addressed is the possibility of the failure of the memory
> allocation for copying the page tables during kexec. If anyone will
> complain in the future, we can look into adding a fallback mechanism to
> do the relocation with the MMU off.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thank you.

Pasha
