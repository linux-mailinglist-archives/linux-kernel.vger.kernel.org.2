Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2F379FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEKGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:43:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43795 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEKGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:43:07 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210511064159epoutp028e7ada2987e8145e47aac81d97695ada~97-7z6_t32013020130epoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210511064159epoutp028e7ada2987e8145e47aac81d97695ada~97-7z6_t32013020130epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620715319;
        bh=R5Mr8semJgMYJDEcFx4DnQVikV0IeL0CBLCY3OJUJJw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UI9H//h7oyIO3jeD+XYLdYQ5DLz02atXS6DF9xBxJNA7F2CrA142AiCKDUDNlmS7z
         R6i0BFzimMWLW36wAlcQ2ET5xRSu2+S0u8bfQ360t2oamjVyrBK7cOAXmjRQ5Q/JXA
         itSVoeu8TKQAGSvr8j37Ri9C/LX+jUbdXM9/rn8s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210511064158epcas2p40c24e3b85f9db3d14ab90afe607816c6~97-7fgdJq0495604956epcas2p4f;
        Tue, 11 May 2021 06:41:58 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FfSyF50TBz4x9QF; Tue, 11 May
        2021 06:41:57 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-6e-609a2734c59a
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.B2.09433.4372A906; Tue, 11 May 2021 15:41:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] f2fs: set file as cold when file defragmentation
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <fc7f1b2b-60ea-eb12-3195-7b3ad0b3adc2@huawei.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210511064156epcms2p1351480bea36733f2e00022bd295e829e@epcms2p1>
Date:   Tue, 11 May 2021 15:41:56 +0900
X-CMS-MailID: 20210511064156epcms2p1351480bea36733f2e00022bd295e829e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVNdEfVaCwb3XJhanp55lsnh5SNNi
        1YNwiyfrZzFbXFrkbnF51xw2i6mP17I6sHu0HHnL6rFpVSebx+4Fn5k8+rasYvT4vEkugDUq
        xyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhYYFecWJucWleul5yfq6VoYGBkSlQZUJO
        xo0l/5kLzkpWzG47wd7A+FG4i5GTQ0LARGLFuh2sXYxcHEICOxglltyZwtbFyMHBKyAo8XcH
        WI2wgKfEuosr2EBsIQElifUXZ7FDxPUkbj1cwwhiswnoSEw/cR8sLiKQI3H1029mkJnMAnsZ
        JbY0nGCGWMYrMaP9KQuELS2xfflWsGZOATuJ92e62SDiGhI/lvVC1YtK3Fz9lh3Gfn9sPiOE
        LSLReu8sVI2gxIOfu6HikhLHdn9ggrDrJbbe+cUIcoSEQA+jxOGdt1ghEvoS1zo2skA86Svx
        ZLYTSJhFQFXi686JUCUuEi/3TwKbzywgL7H97RxmkHJmAU2J9bv0QUwJAWWJI7dYYL5q2Pib
        HZ3NLMAn0XH4L1x8x7wnUJepSaz7uZ5pAqPyLERAz0KyaxbCrgWMzKsYxVILinPTU4uNCoyR
        43YTIzg5arnvYJzx9oPeIUYmDsZDjBIczEoivKId0xKEeFMSK6tSi/Lji0pzUosPMZoCfTmR
        WUo0OR+YnvNK4g1NjczMDCxNLUzNjCyUxHl/ptYlCAmkJ5akZqemFqQWwfQxcXBKNTAp8dV9
        3RCT7Wwn1HXBg+FJZt6Spbs2bg2vVG46eWDuco6Vf6xdbP9c+v56/1Px/guaWmIs0hNcnm16
        sXWjwSsuU06b2Ysik/T3VMsvj9od0DHBddbq9v0LYnsWPj8VHLCcM/Lj/T3mXQ47BG7k2FzL
        2B41qX3hsSnBk3Zk5uu/tmRmlDHunnBaeWJcjdXP8g+TJq0t7vZ+dPDbmmnLNP6XrPmjNMX0
        w5PSxs85FbJheidOflaaIbfjcQSDhADzgS133Xt594rcPf1XYrOo3enfc7blbAnbGZEQ+j+u
        zy2gZ6qebubDMoEJ7/sVtO+lz2fVlFY1K1Z6e/faik7ZzL6XhlLefmezdfmqqzqWCgsqsRRn
        JBpqMRcVJwIAhnPsuhcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a
References: <fc7f1b2b-60ea-eb12-3195-7b3ad0b3adc2@huawei.com>
        <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
        <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
        <YJN0nTgadoq8vDaG@google.com>
        <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
        <YJlHmP/ej8/IsHL3@google.com>
        <6e95edca-4802-7650-4771-5389067935dc@huawei.com>
        <YJoRcIpW1g/OgHZn@google.com>
        <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2021/5/11 13:09, Jaegeuk Kim wrote:
>> On 05/11, Chao Yu wrote:
>>> On 2021/5/10 22:47, Jaegeuk Kim wrote:
>>>> On 05/06, Chao Yu wrote:
>>>>> On 2021/5/6 12:46, Jaegeuk Kim wrote:
>>>>>> On 05/06, Chao Yu wrote:
>>>>>>> On 2021/4/29 14:20, Daejun Park wrote:
>>>>>>>> In file defragmentation by ioctl, all data blocks in the file are
>>>>>>>> re-written out-of-place. File defragmentation implies user will not update
>>>>>>>> and mostly read the file. So before the defragmentation, we set file
>>>>>>>> temperature as cold for better block allocation.
>>>>>>>
>>>>>>> I don't think all fragmented files are cold, e.g. db file.
>>>>>>
>>>>>> I have a bit different opinion. I think one example would be users want to
>>>>>> defragment a file, when the they want to get higher read bandwidth for
>>>>>
>>>>> Multimedia file was already defined as cold file now via default extension
>>>>> list?
>>>>
>>>> I just gave an example. And default is default.
>>>>
>>>>>
>>>>>> usually multimedia files. That's likely to be cold files. Moreover, I don't
>>>>>> think they want to defragment db files which will be fragmented soon?
>>>>>
>>>>> I guess like db files have less update but more access?
>>>>
>>>> I think both, and we set it as hot.
>>>
>>> Then hot and cold bit will set to the same db file after defragmentation?
>> 
>> Do you set cold bit to db files? I mean, generally db is not cold, but hot.
> 
>I never set cold bit to db files, I mean if we defragment db file which
>has less update and more access, db file may have bot hot and cold bit.
> 
>To Daejun, may I ask that is Samsung planning to use this defragment ioctl
>in products? what's the user scenario?

It is just my idea for defragmentation, not Samsung.
I think the user will call the defrag ioctl for the files that have been updated.

On the other hand, I think FS should be able to support defrag file even 
when in-place update is applied. What do you think?

Thanks,
Daejun
> 
>Thanks,
> 
>> 
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
>>>>>>> "system.advise" -v value) to indicate this file is a hot/cold file, so my
>>>>>>> suggestion is after file defragmentation, if you think this file is cold, and
>>>>>>> use setxattr() to set it as cold.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>>>>>>> ---
>>>>>>>>      fs/f2fs/file.c | 3 +++
>>>>>>>>      1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>> index d697c8900fa7..dcac965a05fe 100644
>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>> @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>>>>>>>              map.m_len = pg_end - pg_start;
>>>>>>>>              total = 0;
>>>>>>>> +        if (!file_is_cold(inode))
>>>>>>>> +                file_set_cold(inode);
>>>>>>>> +
>>>>>>>>              while (map.m_lblk < pg_end) {
>>>>>>>>                      pgoff_t idx;
>>>>>>>>                      int cnt = 0;
>>>>>>>>
>>>>>> .
>>>>>>
>>>> .
>>>>
>> .
>> 
> 
> 
>  
