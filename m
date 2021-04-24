Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E136A1A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhDXOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDXOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:37:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:37:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a25so45552873ljm.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uoH4H/qXa4Hgq9FClpPx5Dd1jyM5vAg3STeuwuUsMrM=;
        b=R5+47fg2JRT8b1JFcau5QKkKNNrVbDJ9eorTWPmron02FSe1B6uz22b6WJRS9xk6vy
         ryaJvb91zrghAXcsNyFmSj1Mmd/AaOcrw57gha4nL2MwH3QSVcqKfLYPHSINGRQE2W8W
         KWPAKE2+bZ+SrCZntoEYkx75yT1cjKasMn864wU8PMP9dO6PIFPShZZvb8vyinC5FHkW
         SfVq0+e3yKpyOEGHJ5nrqexpIHEHRusjtC5QFbkq9NMLl1ZZzSbJ8wypyZ98W2Gj8np/
         nKxvwBho8zISh+gR9kkNhnwxtuC7DFcRa2w0wqEhu4bFVcMcBYSAfwEYa+4+Wp7naA0i
         UjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uoH4H/qXa4Hgq9FClpPx5Dd1jyM5vAg3STeuwuUsMrM=;
        b=ArjLtqjjMjfpcvZlU9vFnWBR3bjsUzLYYMRkIfrK2BAA/3PIRKFNq0x1w8q3jTXPHW
         fQtc55uP+jWlco2nOJWwFlVbmZwAGT+Vdb4n57zwKsKnV84H9oPXPoi8Ow2b9waM2ja8
         y3v9WDmlk0KAP7at5V9eJp1L6u9IgDqHbKpCFckIcAw1H6EDBpzsZoLXEzs9vzn0ojS0
         5cBcYb65O0CRNOjiA+JpqZVXxFjDDDg9lorZmClk5pM4m6m6xUvptHQkj3gmoIub8563
         9nOy0+Pdb8kIVAVKxcE7QiwDGvs4P6rld07wNJmf/xHPTmb3LWFlFRNYM9SA2QX8NwKK
         92vg==
X-Gm-Message-State: AOAM532oOSbtN2Hc7+/Cx0Qv1EGeCIxbuqL+21l2AuwuuyBkPm84eICU
        vMlFW18m5SEYlaflUdHCXV3BGnGghMbVdR+xvP/gxF9Pql2bHH2D
X-Google-Smtp-Source: ABdhPJySHRSJNlYs06zs6c5IJXEasLWi9mJck6gduE1wPps9RrO4Ua2TDbKsgpqrqeqnccCSersGmdTwtjCdUgHzV6o=
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr6138999lja.297.1619275039634;
 Sat, 24 Apr 2021 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210422151022.17868-1-sxwjean@me.com> <15aac264-8626-ad15-7301-044c622d7f60@csgroup.eu>
In-Reply-To: <15aac264-8626-ad15-7301-044c622d7f60@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Sat, 24 Apr 2021 22:36:53 +0800
Message-ID: <CAEVVKH8K84=DuQy370eVv4kx24nHiOqnputtERLuGoc4-MwYtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Make the code in __show_regs nice-looking
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:27 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/04/2021 =C3=A0 17:10, Xiongwei Song a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create a new function named interrupt_detail_printable to judge which
> > interrupts can print esr/dsisr register.
>
> What is the benefit of that function ? It may be interesting if the test =
was done at several places,
> but as it is done at only one place, I don't thing it is an improvement.
>
> Until know, you new immediately what was the traps that would print it. N=
ow you have to go and look
> into a sub-function.

How about replace if statement with switch statement directly, like
the changes below:

@@ -1467,13 +1481,17 @@ static void __show_regs(struct pt_regs *regs)
        trap =3D TRAP(regs);
        if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
                pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-       if (trap =3D=3D INTERRUPT_MACHINE_CHECK ||
-           trap =3D=3D INTERRUPT_DATA_STORAGE ||
-           trap =3D=3D INTERRUPT_ALIGNMENT) {
+       switch(trap){
+       case INTERRUPT_MACHINE_CHECK:
+       case INTERRUPT_DATA_STORAGE:
+       case INTERRUPT_ALIGNMENT:
                if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
                        pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar,
regs->dsisr);
                else
                        pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar,
regs->dsisr);
+               break;
+       default:
+               break;
        }

Thanks,
Xiongwei
