Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34434A118
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCZFii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCZFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:38:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84DC0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:38:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l1so367353plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=87Df9w+HLEtQIYbykZK6bC5setLTpy5vdBvKQb+SxG0=;
        b=aiVnRhdXR8vqYfZs7pR9AAdR+ScJHjfTl952RwX/4aJVw7oHFCSUCBgIrXS5rzdA0G
         Od/yPxM+UBMZbP9usp1GQ4peMtXL+AnkFzvWqNVQvLvvSSh7aIIXmu77zSVJ6PSsV6GN
         w3BV/SekzvMkknp+8SOKBVK0jKaYbL9PcwbZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=87Df9w+HLEtQIYbykZK6bC5setLTpy5vdBvKQb+SxG0=;
        b=rTr8KrhHe/8OvW6AO7tEexCv9BDP2Slh+b9xDEEkqZg7glUcfsfsAEEqF2dEyiSRnb
         YVDmdPE5HvihSsd/gPTGXLgEUoMlG1tEZbxAj32BTu+olodOUcZdLSfN9kE3cwteIp6P
         O19gtrTEP8Ue/VO88QkVXuBsghtztNBvpN7R00hmiTlHMm5w/hS5CVr6LllpjBquPIHZ
         u6r5sjGhCHFxG+itSRFI0+x4CYGRm1ZgnOZCZd+QCQypa+buD9RtoAyc3HkY8JrzaEx+
         A2qcBqplChdLTc6QtuMnrEnQsfF4zWvliGssGDHFg24QuO4LGJifH6DLa57wjkX7QT50
         8biA==
X-Gm-Message-State: AOAM533dm1RkPY0H711/N94K8y7QhAsMjm+z0cyMHBqzjK2DBEb3+I4T
        gpqK0bQObjgmCP13Asd245BI6A==
X-Google-Smtp-Source: ABdhPJyvcXRQyAYpeNoyjsN9TtaOvpteuYOcXzmzRTWnnmi5naQ0BxtrTjUBbMsEaOFtaevNqkz+Bw==
X-Received: by 2002:a17:902:c317:b029:e4:aecd:8539 with SMTP id k23-20020a170902c317b02900e4aecd8539mr13673784plx.61.1616737090389;
        Thu, 25 Mar 2021 22:38:10 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id s200sm7803561pfs.53.2021.03.25.22.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:38:09 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] [v2] arch: powerpc: Remove duplicate includes
In-Reply-To: <20210323062916.295346-1-wanjiabing@vivo.com>
References: <20210323062916.295346-1-wanjiabing@vivo.com>
Date:   Fri, 26 Mar 2021 16:38:06 +1100
Message-ID: <87y2ea79vl.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> mmu-hash.h: asm/bug.h has been included at line 12, so remove 
> the duplicate one at line 21.

Looking at the file I had wondered if this was due to a #ifdef being
removed, but no, the second one was just added in commit 891121e6c02c
("powerpc/mm: Differentiate between hugetlb and THP during page
walk"). How odd!

Anyway, all of these look good to me, and the automated checks at
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210323062916.295346-1-wanjiabing@vivo.com/
have all passed.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
