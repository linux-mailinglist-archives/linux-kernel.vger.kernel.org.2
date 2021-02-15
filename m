Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4980131B630
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBOJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:08:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:14124 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhBOJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:08:47 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210215090801epoutp01d4bd10f7d2f512768b506e3e5f2f4f62~j4KK6Z2GL1814318143epoutp01B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210215090801epoutp01d4bd10f7d2f512768b506e3e5f2f4f62~j4KK6Z2GL1814318143epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613380081;
        bh=T4c5TgkHp4DQfkZYsZurR1ayDXVOg3RCRySDJpJvPtY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=orTCgkZCcJiL1f7VzpBm/9XEiuHaSx1S++Q8gnpLrTFwT5hkvsjB9/ZcgB5NREIs5
         k5HKCSgK328Avv9q3DpkljO5DtndnK2dLTb81VOTErbtxQHhnSr4CZEgJzFgFFinsE
         W8Gw2Yj25HblWBq4rPk7/ytrQ6V5DQ54RmSjbS2Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210215090800epcas1p242a15e454fe425f8442ec07705d15704~j4KKk_8AA2834028340epcas1p2O;
        Mon, 15 Feb 2021 09:08:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DfJCx2vLqz4x9Q1; Mon, 15 Feb
        2021 09:07:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.3D.10463.DE93A206; Mon, 15 Feb 2021 18:07:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215090756epcas1p14de6e0dbfbd7aa186c63ad5b23acb54b~j4KGSPi_R1897018970epcas1p1Q;
        Mon, 15 Feb 2021 09:07:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215090756epsmtrp2ede9db07e8f7d9f91496b6d70b807cb5~j4KGRdGrT0984909849epsmtrp2d;
        Mon, 15 Feb 2021 09:07:56 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-79-602a39ededdb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.38.13470.BE93A206; Mon, 15 Feb 2021 18:07:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215090755epsmtip2e881bfeb984dbe3cc5ceeaef043cde12~j4KGHS5x-2950029500epsmtip2j;
        Mon, 15 Feb 2021 09:07:55 +0000 (GMT)
Subject: Re: [GIT PULL v2] extcon next for v5.12
To:     Greg KH <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, chanwoo@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ca294a73-57f0-c3af-3d33-d592aaf4e15c@samsung.com>
Date:   Mon, 15 Feb 2021 18:24:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <YCYzQrMonj78Ut+x@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTX/etpVaCwdYHghYTb1xhsXh2VNui
        efF6NovLu+awWdxuXMHmwOqxc9Zddo9NqzrZPPbPXcPu0bdlFaPH501yAaxR2TYZqYkpqUUK
        qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
        +nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZbzbfZS64xF2x
        79tctgbGDZxdjJwcEgImEhc2zWXqYuTiEBLYwSjx9tsuNgjnE6PEi8YmFpAqIYFvjBJtm6Ng
        Ok587Ibq2MsocePJC0YI5z2jxKeV/5i7GDk4hAUMJCY/5wZpEBHwlnj/p40RJMwskCdx6mkt
        SJhNQEti/4sbbCA2v4CixNUfjxlBbF4BO4lLz68xgdgsAqoSh782M4PYogJhEie3tUDVCEqc
        nPkE7DZOAU2JSScugs1hFhCXuPVkPhOELS+x/e0cZoibOzkk5j4VgLBdJE53HmSBsIUlXh3f
        wg5hS0l8freXDcKullh58gg4ICQEOhgltuy/wAqRMJbYv3QyE8QvmhLrd+lDhBUldv6eywix
        l0/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLNLCQfzELywSyEZQsYWVYx
        iqUWFOempxYbFpggR/UmRnCi1LLYwTj37Qe9Q4xMHIyHGCU4mJVEeK9KaCQI8aYkVlalFuXH
        F5XmpBYfYjQFhu9EZinR5Hxgqs4riTc0NTI2NrYwMTQzNTRUEudNMngQLySQnliSmp2aWpBa
        BNPHxMEp1cA0NXJ6X5/pCf/taScq5iYdnK2RwDD9RrKP1uJ7/JNPeGWachx9JsZhe+njgqI1
        ghJamu+/vGy5vWXN7JOCv89ZbixYv+fGpZPTy6ewbNue+z/NVW/z7VfeXUu1L6T1xHExvMy3
        1zxZZXLGLHVmQt4Vs8UVhnq/DHaqF3nvaKxN/Lb1x7Kud/HPjVdeEfv+9FpO0CaWgIItTHLV
        O2R0/lhq8Eclv17wUfzg0qesH95ELU+9/KmA55puyo+77G6mFeIyeuW2TKFzfk4KK9g+8dae
        GwfOWMWd/etY2/HzfExgzbUbt6ztvE+vkGo6LPVyW8mB5LDncnerzCv0bBu8e2+n39R4tp6T
        4fPe6rv+yksUlFiKMxINtZiLihMBkIUcLR0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO5rS60Eg+5bNhYTb1xhsXh2VNui
        efF6NovLu+awWdxuXMHmwOqxc9Zddo9NqzrZPPbPXcPu0bdlFaPH501yAaxRXDYpqTmZZalF
        +nYJXBlvNt9lLrjEXbHv21y2BsYNnF2MnBwSAiYSJz52M3UxcnEICexmlFh6YQ4LREJSYtrF
        o8xdjBxAtrDE4cPFEDVvGSVet09hBIkLCxhITH7ODVIuIuAt8f5PGyOIzSyQJzHv032omYcZ
        Jd7PvcwOkmAT0JLY/+IGG4jNL6AocfXHY7AGXgE7iUvPrzGB2CwCqhKHvzYzg9iiAmESO5c8
        ZoKoEZQ4OfMJ2G2cApoSk05cZINYpi7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArPQtI+C0nL
        LCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERw3Wpo7GLev+qB3iJGJ
        g/EQowQHs5II71UJjQQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
        ZJk4OKUamMJmmsVXXJ0gvNpy6jE/Vf4jKjvT03ZP+F97hl/VrfueafebFZGFK2bXHteR67XY
        uk1ys1/UX+37FUEvYzX/V6hVT7gSekFOY+adX4ryoilvzpR3qj0+9qHaMvGT67LO2Rolmn++
        bisN4d9/oeH601OOl7bvmtyz7Nt5tpkXRHhY2ssSPuV/cpnjZ7I/9tCWC+H3A2dc3vE4PLb5
        8VTFiUU1Opty13Oct5EszGjeGvgveP/Kj78LPzcLs7+d26kfuTTvtm2DjuxLY9emoqacQ72a
        pYnHtuikcFtu6vzD4hI7/aNumcMbRuZ5V3ifWqQseS7p5fzZ4Y7LXhd7f+m5ec4PXaI59p7h
        4ZQ8vrhdQYmlOCPRUIu5qDgRAK76OlgKAwAA
X-CMS-MailID: 20210215090756epcas1p14de6e0dbfbd7aa186c63ad5b23acb54b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210212075032epcas1p25c3ceb59ddcf63a1db4328758527acb4
References: <CAGTfZH1o6zdN_42KJkVcA++QpSyY4_tMMFJSQFmWhKv7PWrghA@mail.gmail.com>
        <CGME20210212075032epcas1p25c3ceb59ddcf63a1db4328758527acb4@epcas1p2.samsung.com>
        <YCYzQrMonj78Ut+x@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On 2/12/21 4:50 PM, Greg KH wrote:
> On Fri, Feb 12, 2021 at 02:19:37PM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> This is extcon-next pull request for v5.12. I add detailed description of
>> this pull request on below. Please pull extcon with following updates.
>>
>> Changes from v1:
>> - Add missing committer information
>>
>> Best Regards,
>> Chanwoo Choi
>>
>>
>> The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:
>>
>>   Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
>> tags/extcon-next-for-5.12-v2
>>
>> for you to fetch changes up to bd30a35764e136dc372e74c4856de633cb7ed8de:
>>
>>   extcon: sm5502: Detect OTG when USB_ID is connected to ground
>> (2021-02-10 08:15:28 +0900)
>>
>> ----------------------------------------------------------------
>> Krzysztof Kozlowski (1):
>>       extcon: Add stubs for extcon_register_notifier_all() functions
>>
>> Nikita Travkin (1):
>>       extcon: sm5502: Detect OTG when USB_ID is connected to ground
>>
>> Timon Baetz (1):
>>       extcon: max8997: Add CHGINS and CHGRM interrupt handling
> 
> No diffstat???  How did you generate this pull request?

When I copied and pasted the body of pull request,
I was not adding the diff statistics. I'm sorry about my mistake again.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
