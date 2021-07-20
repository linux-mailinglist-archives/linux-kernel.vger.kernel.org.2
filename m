Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B63CF8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhGTKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGTKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:34:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:14:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso1381676wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Scwye6C+1Um7vvUcoTZkRoyEhyT2SXL6uA5lCU/qAvo=;
        b=LMlxufPUPb2baVXBQ3VbdR5xUqZGe2i72q3p54Pd5N2AVVhCquwFd4vXoKMg94uLVz
         /DBufDYbJzPrm5yrCS7IHjx3emOa9cb1Q0XM2TNV21BgR6KoqX8NA7w21Ha2Cb8Bd+hV
         lYjoz7AFqJBKqgDZ1an+6fpOGpIp7utuszeDBxbe9tnYmbci25MtjjS1Z0BA9D7tUugc
         K+XnVi6J14aPrCi7ed8GeyQkKM6l5EkOw0hkLlsLXvhfBYVtPkFnZCVPZ08omY+DF4JU
         K5NO5ElFz242783F1DGmAGs4XfB2LfvVZcGvHX1zo46qXqGaitIlyqU1ZFEg27srQi13
         DbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Scwye6C+1Um7vvUcoTZkRoyEhyT2SXL6uA5lCU/qAvo=;
        b=lkglPl78oZulWwyCvSwu4dMW+r6T3fMIhs+FH7s95NijCsepNydlvM3BXnwSrpCx+o
         lcWOb0P1DNZCR/fEVGA3RJCLULwBvTyOA8IEADKZTmtxu5lztbAwWkkOSgwzoc7T6/tm
         IsMvumSEW/yF6F/rETqbGQlhBuY1ay5ykGbasGoo9EHAsCuHMoPUXj1PhNjL34dR2Pg8
         EZLiYWa6HX4osaupYl09zb9O7w81/IiE4i7nYKIVTk8xGYbIFp9hwi8Sv74uMOvV0YGW
         ZxBZ1MMgqBe1640G6Darew4Ms7pANgqSZQUXc/u4F5NuZKNY1piYDfjY8RpAovWn35b6
         VMhg==
X-Gm-Message-State: AOAM531hWN/kDO1TNCjzSOhUYokI1DkjQKYig+dTu6EjLZozYcQEjVE2
        RX5DyBE+5gJyCyd+thDBN2TeSw==
X-Google-Smtp-Source: ABdhPJzLUrGFdy1juyhle9qtZp590ppxip5Hwthbwjk+yQgROG4vDqXreJVzBkI8J/0J3xXVMKtb6Q==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr30516940wmb.167.1626779693865;
        Tue, 20 Jul 2021 04:14:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id s13sm23219117wrm.13.2021.07.20.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:14:53 -0700 (PDT)
Date:   Tue, 20 Jul 2021 12:14:50 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to
 set ignored bits
Message-ID: <YPawKkT2ZdVzQbM6@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-7-qperret@google.com>
 <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com>
 <YPalr09gA6tGYVtl@google.com>
 <CA+EHjTz__zjYY2D8+nEPq2F8__saxC0kApnn7_rs0r2VCR2Nzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTz__zjYY2D8+nEPq2F8__saxC0kApnn7_rs0r2VCR2Nzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 Jul 2021 at 11:59:27 (+0100), Fuad Tabba wrote:
> Thanks for the clarification. It makes sense to preserve the existing
> behavior, but I was wondering if a comment would be good, describing
> what merits a "needs update"?

Sure thing, I'll add something for v2.

Cheers,
Quentin
