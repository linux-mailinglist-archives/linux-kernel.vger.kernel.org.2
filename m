Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32851421AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhJDXsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhJDXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:48:35 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCDC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 16:46:45 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f13so7792626uan.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=2+1RgBjt2vk7uSWTomzj9kzb61LfSvUq3AulKll1874=;
        b=Ot2zKwG4joir1YzF25Lf/jlEjNDhdUbV6WlQx0RdzZT9plefHzMG7ILFfxOQtNuZod
         sADjRie14aM5Al4W3pgvvrcqoOKXfGt6qbdHaHXSIwPr15/z7Log6BW1P+zqKgVi33FH
         8+RfNt1AdyM7/nnGsOLeBEzBrNNBnbvSu6PVi36jX1h6D9yHCb+V4W0Ftj2iwMxbfPaz
         vpWP14e6GXF4WXF/Pz+/I8ZziKMIpiUsZFutbzoySwz7Tq78KpP4+ttn+/3f4ejp9vcH
         YRFnpdBJ+losKyw1UCXqFbw5W7XLrW6vqXomIHVViTIvcdueP1ZKCQmIl5Z9Dnui2Y+i
         gOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=2+1RgBjt2vk7uSWTomzj9kzb61LfSvUq3AulKll1874=;
        b=VEZJdsdcufhLaj1aiQWDFxmBVkxc0MknCsLsKZ4NFnO+6LH15OnyzHLW5tI1Piv+mi
         Vm6O9yUE6oat3q8z5eDX5zthn0A2IMNs+wgb+TXf3YxG9JogRgEFYMQMrY9N7NOrwY4O
         NdyWaT1AZsDouqwv+IMbQZaXL3yC9KU38zyu9gEuxAiXyf6Mp0srs7szHLAPzQRtTak/
         Kw8saFlMahbQJlZf/RiOPB8sMHlnOReSYBoglHr+5FT4U0idTNI3MvK/axxnOS4IP1vq
         Tmo/jrFK85KX5zEup0wFIrRY36Zo3jjKnTbWjmcOC7QKvirypE7Tqscpqb0WIbJnQ+OA
         yE5w==
X-Gm-Message-State: AOAM531pxnPWfT16jpfmnTldYZ9nF7CYevJ9tvAmgfZ3rs/tIVFh5RpS
        6jgg+WAe59IzmpF4ujZa7do=
X-Google-Smtp-Source: ABdhPJyClUXc4094wOCLpWQeZd56OQMSKZS6UCaHIXd/FP2simIGFRUNTK7rweuiMPxlPtFpjPFs4A==
X-Received: by 2002:ab0:5bdb:: with SMTP id z27mr9805004uae.67.1633391204551;
        Mon, 04 Oct 2021 16:46:44 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b17sm7934796vka.27.2021.10.04.16.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 16:46:44 -0700 (PDT)
Date:   Mon, 04 Oct 2021 20:44:47 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, namhyung@kernel.org,
        irogers@google.com
Subject: Re: [PATCH v1 11/13] perf tools: improve IBS error handling
User-Agent: K-9 Mail for Android
In-Reply-To: <aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com>
References: <20210909075700.4025355-1-eranian@google.com> <20210909075700.4025355-12-eranian@google.com> <YT+nwP3jrzgxEdmu@kernel.org> <aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com>
Message-ID: <25C12FFF-3F86-4733-B778-6C01A3138C25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 4, 2021 6:57:09 PM GMT-03:00, Kim Phillips <kim=2Ephillips@amd=
=2Ecom> wrote:
>On 9/13/21 2:34 PM, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Sep 09, 2021 at 12:56:58AM -0700, Stephane Eranian escreveu:
>>> From: Kim Phillips <kim=2Ephillips@amd=2Ecom>
>>> +static void detect_amd(void)
>>> +{
>>> +	FILE *inf =3D fopen("/proc/cpuinfo", "r");
>>> +	char *res;
>>> +
>>> +	if (!inf)
>>> +		return;
>>> +
>>> +	res =3D fgrep(inf, "vendor_id");
>>> +
>>> +	if (res) {
>>> +		char *s =3D strchr(res, ':');
>>> +
>>> +		is_amd =3D s && !strcmp(s, ": AuthenticAMD\n");
>>> +		free(res);
>>> +	}
>>> +	fclose(inf);
>>> +}
>>> +
>>=20
>> We have perf_env for such details, for instance in
>> tools/perf/util/sample-raw=2Ec we have:o
>>=20
>>          const char *arch_pf =3D perf_env__arch(evlist->env);
>>          const char *cpuid =3D perf_env__cpuid(evlist->env);
>>=20
>> 	        else if (arch_pf && !strcmp("x86", arch_pf) &&
>>                   cpuid && strstarts(cpuid, "AuthenticAMD") &&
>>                   evlist__has_amd_ibs(evlist)) {
>
>OK, I've rebased this 11/13 patch onto the new perf_env__{arch,cpuid}=20
>code, and posted it here:
>
>https://lore=2Ekernel=2Eorg/lkml/20211004214114=2E188477-1-kim=2Ephillips=
@amd=2Ecom/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84
>
>The following 12/13 patch in this series changes, too, but since it=20
>depends on prior patches in the series, I'll reply-all to 12/13 with its=
=20
>new version=2E
>
>Arnaldo, would it be ok to apply the two new patches that replace this=20
>11/13?  They don't depend on any others in this series, and it would=20
>save Stephane from having to carry them=2E


I'll work in this tomorrow, thanks

- Arnaldo
>
>Thanks,
>
>Kim
