Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794893AB333
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhFQMFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:05:41 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61168 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhFQMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:05:40 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210617120331epoutp01810a2accdf6ee04b52343fae4f2720ca~JXQOtnYKF2186021860epoutp01W
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210617120331epoutp01810a2accdf6ee04b52343fae4f2720ca~JXQOtnYKF2186021860epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623931411;
        bh=p3oDUzZ22xwh6E5WoNkdy+uQc/pLZ8kUin5waDEeZpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t9v/tYV7xbFEz1quU3TBPEBhxBInuPukuuljlVokp7PhMfv8S3QRUIXcwTWrrFhWM
         buHrpFNL6vxeOkSMawuHr5VeeD+dgHKGsIjx5AfDMD7KsktJaNn9odmSTEQCleSvla
         KCvgWUfMcd6gOeBO4Y/cjm4OL1vtIC+YStgqB6Yk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210617120330epcas2p177f722d2af05d906a24ac0d1a74db20b~JXQOQCdCb3205632056epcas2p1W;
        Thu, 17 Jun 2021 12:03:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G5LL837lYz4x9Pp; Thu, 17 Jun
        2021 12:03:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.68.09717.01A3BC06; Thu, 17 Jun 2021 21:03:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210617120328epcas2p356a4ba82761072ca074090c683b616ba~JXQL6DwWz1127511275epcas2p3u;
        Thu, 17 Jun 2021 12:03:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617120327epsmtrp2267b4091baaa093507e478b088ea1713~JXQL5Gm4D0475204752epsmtrp2m;
        Thu, 17 Jun 2021 12:03:27 +0000 (GMT)
X-AuditID: b6c32a48-4e5ff700000025f5-d5-60cb3a1066ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.8A.08163.F0A3BC06; Thu, 17 Jun 2021 21:03:27 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210617120327epsmtip157c8fb1adad639c617a746ec21e25ecf~JXQLr_VPL3228332283epsmtip1y;
        Thu, 17 Jun 2021 12:03:27 +0000 (GMT)
Date:   Thu, 17 Jun 2021 20:55:44 +0900
From:   Janghyuck Kim <janghyuck.kim@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa
 off
Message-ID: <20210617115544.GB183559@KEI>
MIME-Version: 1.0
In-Reply-To: <YMo1wik1plVotC1N@casper.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRz29N7eXtiql/LYCXOIda8SebSs7I5RHxG3m7k/0DkxRtZe4YYi
        faW3VdFESMZrCAiCczyCYAgyKIIFActmWYvARjQziAPdWhwbUQIrlGQqT1suS/jvO9/v+36P
        8zsHR0ROLBzP0pkYo47WiLFAtNcpkUcTiWOqONtMKFnfacHIr1r/QUlPSykg/7b18kjrzG98
        ctxWj5EuyyafbL/3M5/87ttvAJl/W06u/luPvbCLsjRYANVoNVPdrVGUte0CRlm9nwmo0Uur
        KNXdnEt5fpjAKMfgJJ9atkZQRYOf8FJ2vaVJUjN0BmOMZHTp+owsXaZC/MoZ5UtKeUKcNFp6
        jDwqjtTRWkYhTj6dEn0iS+NrWhz5Hq0x+6gUmmXFsc8lGfVmExOp1rMmhZgxZGgMUqkhhqW1
        rFmXGZOu1yZK4+Jkcp9SpVH3NN1FDK4nPrg94ObngQZhCQjAIXEEzlrughIQiIuIfgA3frGh
        /oCI8AJ4cyCcCywD6Fqt5j9yTEx9v+2wATjx6yUBd/gTQOfQFz47jqPEAThsl/gNGBELiz4f
        F/jpEOIwnO+R+eUI4eXBK9N2zM8HEynwy/FMv1xISODV0k6Ew0Hwes29rYYCfHU9+fatNKHE
        fjh3LdefBhJDOCz/dGO7t2S4NFmDcjgYzo30CDgcDpcfXMU4nAvdzX8JOHMFgIPNLQgXiIe1
        s0XAjxFCDUcK6nj+YpB4Bg79jnL047DYuS7gaCEsLhRxzkPwQY11W70P3lo7ytEU9DYXo9zl
        XAGwesSJVYCnandMVrujGIefhY0DXqzWlwoh9sKvN3AOSmCnLbYR8NtAGGNgtZkMKzMc2blp
        K9h6zVFUP6hbWIxxAB4OHADiiDhEGM2OqkTCDDrnQ8aoVxrNGoZ1ALlvSZVIeGi63vcddCal
        VC5LSIg7JiflCTJSvEeICxwqEZFJm5hshjEwxkc+Hh4Qnse72J7Y3Tmlvd4mz05LujFzfnF+
        OKxjQROR2vdxQQWaij8peWdkvlrhOu9yTs8WTnevV50icgqToyrf6Hr6oMvQonzxwGKMpeng
        5dNMwx7bjyr2p8SQpgnttRzibJ99d6nHq209W5yStxGzTp8ouH88u+t+2cqCJSrVaVeL3O0f
        jd/sKF9cGVyZ91x+7NydjsqgtDd1F9Me7nOeGTu5mRhRHvzuLTl/8/nJunirosq9Fm35L6Ok
        f39/X37Fydn3b6x5XjuFHj4XtJLwx8PXyxzkYuzekrlRU3Jzl7k3x94a2H98IuRVFKlayh2r
        LlMculOcVzW8WwVenorXX2jXhLmXnG+LUVZNS6MQI0v/D2LFFUxWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTpff6nSCwe4nphZz1q9hs1i04juL
        xftlPYwWL3dtY7LY9Pgaq8XlXXPYLO6t+c9qsfrJOVaLrRvXMVq03DG1+P1jDpsDt8eaeWsY
        PRZsKvXYvELLY9OqTjaPTZ8msXucmPGbxWPzknqP9/uusnkcOnCD1ePzJjmP9gPdTAHcUVw2
        Kak5mWWpRfp2CVwZjX/PMhXM46341jGXrYHxO1cXIyeHhICJxNWbOxm7GLk4hAR2MErser2A
        ESIhK9GzYhMzhC0scb/lCCtE0X1Gics75jF1MXJwsAioShzbrwlSwyagL9E+9TI7SFhEQEPi
        zRYjkHJmgW9MEnOm7GACqREW8JO4suERmM0roCmxt2c9M8TMPYwS5w80QyUEJU7OfMICYjML
        aEnc+PcSbBezgLTE8n8cIGFOoKPft+wH2yUqoCLx6mD9BEbBWUiaZyFpnoXQvICReRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnB0aWntYNyz6oPeIUYmDsZDjBIczEoivLrFJxKE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYBLaczMmxDFk
        Y8ppCcOTesVLeNONbnbfUE1SvbJJ5d/yHQ9/NH4WvCKT3fJsQfukz8t+XV50SYRr3dPg9lhr
        l4h93Vc9XikbKXJ9lV+qetH91wwbC/up3eUhZZUxp2xtqhccTBP+duHQWiEZu/O7pX7sr5g1
        W2rqhZZI+dWHi4vq0xZGiWfq3HmXLv9Dw7hu4sNmKU+tvwuiL7SeT5tm+a9+v83NDb96hXMe
        JF8+9X/KVX8rDcvbT/PUDN4ebjzQz7Hx8bSM49vmbecsnfJQbef5vrorvvOffZx6WO16rmhy
        y/3PzDaVnpH+wqZnrbwi/nuU3/Rhyf30yvz7zRDrCOVF83fIHwpZcuH5vK/5feuVWIozEg21
        mIuKEwHJ5m8IHQMAAA==
X-CMS-MailID: 20210617120328epcas2p356a4ba82761072ca074090c683b616ba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbcff_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
        <20210616083745.14288-1-janghyuck.kim@samsung.com>
        <YMo1wik1plVotC1N@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbcff_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Jun 16, 2021 at 06:32:50PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 16, 2021 at 05:37:41PM +0900, Janghyuck Kim wrote:
> > Architecture might support fake node when CONFIG_NUMA is enabled but any
> > node settings were supported by ACPI or device tree. In this case,
> > getting memory policy during memory allocation path is meaningless.
> > 
> > Moreover, performance degradation was observed in the minor page fault
> > test, which is provided by (https://protect2.fireeye.com/v1/url?k=c81407ae-978f3ea4-c8158ce1-0cc47a31384a-10187d5ead74c318&q=1&e=cbc91c9b-80e1-4ca0-b51a-9f79fad5b0c1&u=https%3A%2F%2Flkml.org%2Flkml%2F2006%2F8%2F29%2F294).
> > Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
> > disabling NUMA. To reduce this performance regression, fastpath is
> > introduced. fastpath can skip the memory policy checking if NUMA is
> > enabled but it uses fake node. If architecture doesn't support fake
> > node, fastpath affects nothing for memory allocation path.
> 
> This patch doesn't even apply to the current kernel, but putting that
> aside, what's the expensive part of the current code?  That is,
> comparing performance stats between this numa_off enabled and numa_off
> disabled, where do you see taking a lot of time?
> 

mempolicy related code that I skipped by this patch took a short time,
taking only a few tens of nanoseconds that difficult to measure by
sched_clock's degree of precision. But it can be affect the minor page
fault test with large buffer size, because one page fault handling takes
several ms. As I replied in previous mail, performance regression has
been reduced from 5~6% to 2~3%.

> 

------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbcff_
Content-Type: text/plain; charset="utf-8"


------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbcff_--
