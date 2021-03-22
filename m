Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF88D34506A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCVUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCVUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:03:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A525C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:03:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o5so11933429qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=68vl/yiYvmgcXyVIdTU5oV74UxAPTnnGu+cWQNyF8w4=;
        b=Uuy1g88XODXjEq+N9eRAau/chYdqT38iEE0ZTIA4H21cidDFG+Vk4U7W27oDRL2Lsh
         w2PyVr/agKoRR/842XN6fNpaFrWaNUbIOHu2OKmypnnzQigDHKmNh09Qy75saHLKBuRb
         GajYN6shT94CypuWcS+mUiIMXLxPmpR+5GZ2CkasuUGMwmDOwZxNd8VsZ4Eb9dgH4wFk
         4nG6ZZPF4dODQ/+4MQHKRXDKIg3tSrhlibe5KxTHFZgBx85EgNLPMyhvEK1jNMlfpJ4M
         mQfMBWaotBzv+4gPFYRgFb7Wb0xP0nQIeKV7nVeDmMfKESGppszNIvxGeHLnRrEdIw0Z
         4f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=68vl/yiYvmgcXyVIdTU5oV74UxAPTnnGu+cWQNyF8w4=;
        b=IY12QIN5rOx9n2a9g4kQ0nSaNTSgtXgTsuzpfEFcCJx7mzNYBhHA7DrctAJdA7cy+o
         xhby4LPShTL+FkZkV3zheNxyqk95wXgBPle8VCHX3VxZj3ReFoyPtHZ7b1UW79px2LO2
         mHJX6bcJyboOcuJJ6D7W2nH9lLtVGjcw/656gRHrpmnV9MBhWKnumpwDpK/LuAYpjYy8
         e8LkQ3mpPKTocoNUndtzn+RI6Oqzi8dEKCHwIM04SfudOiz7ZUwVQwGT+q2OScfAPonq
         NBo08TV2cqYbYaiWcWeOAptJL0jHtvTW/PEW+V4gg3ycV8hrEoZCRYC1q+bu8lP8flIe
         LSSQ==
X-Gm-Message-State: AOAM532UPQCIz/V+FL24wx7btAlpyos5Cn/Oqn4XrpGkIEoabeWoeUCU
        zW28MSNOy6PRESuP4NmCT1Y=
X-Google-Smtp-Source: ABdhPJxZ83M8LxBajZE37Gr9K3JPE8kxXZ6WktUzoV/xI2BFQg5LUNL1PqSCy7iiIn8xEfJvbNiVZA==
X-Received: by 2002:a05:620a:102f:: with SMTP id a15mr1911430qkk.87.1616443410877;
        Mon, 22 Mar 2021 13:03:30 -0700 (PDT)
Received: from ArchLinux ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id 8sm11483746qkc.32.2021.03.22.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:03:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 01:33:20 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] nvme-fc: Few trivial spelling fixes
Message-ID: <YFj4CKnnRg5lzN9K@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
References: <20210320203002.13902-1-unixbhaskar@gmail.com>
 <BYAPR04MB4965A5E081F84BA874957F3186659@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3smuvP2HPx3sPm+l"
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965A5E081F84BA874957F3186659@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3smuvP2HPx3sPm+l
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 18:36 Mon 22 Mar 2021, Chaitanya Kulkarni wrote:
>On 3/20/21 13:45, Bhaskar Chowdhury wrote:
>> s/boundarys/boundaries/ ..... two different places
>> s/assocated/associated/
>> s/compeletion/completion/
>> s/tranferred/transferred/
>> s/subsytem/subsystem/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Patch looks fine but commit log could be better.
>
This is the best I could produce.
>
>

--3smuvP2HPx3sPm+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBY+AQACgkQsjqdtxFL
KRVoYAf/Rag2bPMPPqtcm9y7wgH9ZcQVNcpKuGP/PPUmUVbzdkp/jxQcninJm+Pr
Uk5M0SCerITQS7rIFISBvQCmb0aG5GzyPhqqSB7oF/XdRqyHBgcS1ekXbYy2cQhF
Xb3t6GvOeTBU1U7GPd1n/TopSNA4wHcK1B55LKEotuNmFsxd2CJQf8KWl7iGTNMQ
Ah0Yr//dciF0kUFDYNFIygnhvZPCyQb1iqyOitc9nstHmzAHFp6zKNSnLgnaPRys
LSO6EfzRm0hMGkT9Upp+5cRfgT2Hy8ahFN7MbL0Bo1IU+qWBHU3rmS12xXP1sPVq
4YsGrl45jNjdlMYIbw9g50HS1U+6yw==
=0zL/
-----END PGP SIGNATURE-----

--3smuvP2HPx3sPm+l--
