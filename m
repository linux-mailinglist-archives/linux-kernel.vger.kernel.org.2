Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0D38259A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhEQHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhEQHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:45:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92605C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:44:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e19so4375809pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=c//JpD/uYQv9efR4mX5SgFT+57KIyKuAcRKu4zsF6gg=;
        b=AwY2Ozni7GjWrpfCKsVhAkIlJVEeBY3N7MS4eGI0fBX1DoZbvWbZvbYb6YVV4NPHxe
         1woSPmyw5eHCf1Hpnk5S1+z0tKYZHLAb2nZR2qlf/ftP2uu5dUm3k++sAvI3T+ix+48h
         6D4lrvGd/xfGcgymTiGaceL85VFZKhRlNO6lAWlHwBJV7l+XapZJYr33qTvP/dn5o6bQ
         CGVzvjKDRPvGsPAsNajw6NBQ+4irtZMeoqFF8MuPP4+Ps1pTYU0AHBlQRcirPcUn0vOA
         jwoITmks4KPV5YX7lIeBkDlY8cIygGxprqPUcloWqMJqNN6z4vmFYP0rWuprhNB207qc
         P6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=c//JpD/uYQv9efR4mX5SgFT+57KIyKuAcRKu4zsF6gg=;
        b=JHoQ8KhASEDXnynuz2VZzUaiti/gmJ6Yv9p6SUm1slHwRxy5wkyCWPs46NXWegJyDy
         PtAWkofUL9HmtFx+YeCwyQNNprM6oCi6zQPS2jgu+OdTvrMa1d2d9QVXUZqA+Xi6PSFn
         HALfULjo8UgZfa17Tmo6h1nS+xFnaaS8mhGg0uGNoB70XFMkuZMDMckcBJcKjlkNhKh6
         iSAnT+TT0N6PccNXbXWTAQR6NwTMfPm37y2N41r2q8poNTPqUblreCPSyqBswS3xafz6
         8BVhyIcKuz//BfjV5Cj+fV0s4O93Uri1Buu2CITZ7qhkRp6aX61Jvlb9/enf71hiAj3J
         kmIA==
X-Gm-Message-State: AOAM531ueSyqpQmHgwNDn82QJHWkMj5D+blEJsbNnjrc0DWKR23qupAC
        vJVW9fMAjDGNAyQD2phT9JeQVZxCcjw=
X-Google-Smtp-Source: ABdhPJyh/K9tMM0ffPn7cD+k7NntE+uD9AsQ4kF8sI8UivDrFYNpogPyQ9yMUthC2xcnyr/TqP8UlA==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr55505670pgr.324.1621237471270;
        Mon, 17 May 2021 00:44:31 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id j17sm4322643pff.77.2021.05.17.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:44:31 -0700 (PDT)
Date:   Mon, 17 May 2021 17:44:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/interrupt: Refactor
 interrupt_exit_user_prepare() and syscall_exit_prepare()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cd0634769e5fea397411a0f833db52749852c6f8.1620980916.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cd0634769e5fea397411a0f833db52749852c6f8.1620980916.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1621237386.33q9uyrpc3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of May 14, 2021 6:28 pm:
> Last part of interrupt_exit_user_prepare() and syscall_exit_prepare()
> are identical.
>=20
> Create a __interrupt_exit_user_prepare() function that is called by
> both.
>=20
> Note that it replaces a local_irq_save(flags) by local_irq_disable().
> This is similar because the flags are never used. On ppc 8xx it is
> more efficient because it doesn't require reading MSR.

Can these cleanups go after my interrupt performance improvements?
I posted them for last series but were dropped due to crashes without
time to resubmit. I'm working on them again now.

Thanks,
Nick
