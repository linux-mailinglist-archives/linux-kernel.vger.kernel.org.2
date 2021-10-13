Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2742C78C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhJMR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhJMR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:27:11 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:25:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d20so2138835qvm.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5B9e1Cyi0JhwKWEml7iuPih0nBAtWtEukFOrjjJnY0=;
        b=f+bvuZ6JlYfGopABNgCneINt/jqcD0o7QYvRv8DV5elz3c9CpVryuAwTSBzor5IdP0
         yzO406sYsOTmRhEZ6K8FKqiG3GHEYFNXG2WRO0K0emxr8BDPIKTwZ8LUD0Izc+mXjnNF
         uNpjwAJcMjqxKdzS9WlG5BW5l0O89Hz4uLBtruj2EM/+JiUbleA0HafQBBnfP8NPIjex
         LX7tx/O1dlIFeqVasAOrLsxirjiWkDtl7LjFmexe/HDzCaqEU369EIguu2ziUX3V/DUa
         zvTb8HPMrymg6vX9QTMAEijxGbYkG1MvIuXd3jWZztLB++3ODvGbn+hyjheGWwn4tUkg
         YiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5B9e1Cyi0JhwKWEml7iuPih0nBAtWtEukFOrjjJnY0=;
        b=uw2cA7WmpNb/ERjZkOaealLqhl2HSiayCQcpbPhf6JsTVaOQBJi6x947IuaiJ/eBT8
         NW1QyfrMdyoQAie08yXX60/AWVfs30DhPHANH0zZv89JiLGsUrNWTTooxEQSWMiriyBh
         Zg87D/+ruvtgLMdUKQWmKeEil+n7kLq7JXptXlamGSBmKjRhcR80ryCRndtxdbJ2B9pB
         WnMqZHRqJNtwtyyVoMQl1QS4Lf8FLMJvu7r1FD4h6QhFQuMrNtN1ogNc2ge2V6B3zDkA
         CldoVt9K4ECt3hmHb0dXUqVsPywkmdZ3e6VC7SDnDhCwAASGYtuzpchpNPTAIop3W8hZ
         M8FA==
X-Gm-Message-State: AOAM532O/4u7h1p6A4gAgh8n3NNWsNO31MLsz0W+42D7uBmlF6cphc98
        GSSU5gALDwX1lsYTXPO+ukmyhX65i8T8UmZcLV6dwg==
X-Google-Smtp-Source: ABdhPJx6YyZ/+etdKFX6+ZvhxFnw3OJipzQgmPjSPysSm4HVGBCwTGzggnrRlwwt8VN2N9FOPBJimKbN6+UB7foi4Gs=
X-Received: by 2002:a0c:aac2:: with SMTP id g2mr202369qvb.41.1634145906145;
 Wed, 13 Oct 2021 10:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com> <20211012234606.91717-2-ndesaulniers@google.com>
In-Reply-To: <20211012234606.91717-2-ndesaulniers@google.com>
From:   Christian Biesinger <cbiesinger@google.com>
Date:   Wed, 13 Oct 2021 13:24:28 -0400
Message-ID: <CAPTJ0XEQn7W-2a3NPUZYt4Jr1nKCVVp2W-uKTfdiFEbiyuBQcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: vdso32: drop the test for dmb ishld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Simon Marchi <simon.marchi@polymtl.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Oct 12, 2021 at 7:46 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Binutils added support for this instruction in commit
> e797f7e0b2bedc9328d4a9a0ebc63ca7a2dbbebc which shipped in 2.34 (just
> missing the 2.33 release) but was cherry-picked into 2.33 in commit

Shouldn't that be 2.24 and 2.23, respectively?

> 27a50d6755bae906bc73b4ec1a8b448467f0bea1. Thanks to Christian and Simon
> for helping me with the patch archaeology.
>
> According to Documentation/process/changes.rst, the minimum supported
> version of binutils is 2.33. Since all supported versions of GAS support

(I have not checked whether this version is correct or not.)

Christian
