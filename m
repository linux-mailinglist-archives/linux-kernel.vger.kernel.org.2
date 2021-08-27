Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD263F9429
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhH0Fvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:51:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50238 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229645AbhH0Fvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630043447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npLTWiPze+/cNByg6fkWwO2/MY5pEO1zok8sjXDfudI=;
        b=UQw3H2ywWE2p0KF5BOuncZnRJQMwpNj9oL36yixFKZFWy5GBId5Kb28Y84WkBsZd8EJo4J
        pl3aQXPPsX/G87TZi8HBKdVZ0cnjBJHvXx3L70RqJTQiI0odqb8WduYnmUvCXrLSbcFJvK
        zmzJ5Yb4c6TJffTwC2sp/PT++YievZ4=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-4RXrjSXyPIKdh7D7E7pllA-2; Fri, 27 Aug 2021 07:50:46 +0200
X-MC-Unique: 4RXrjSXyPIKdh7D7E7pllA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQJBtezb/L2O2lv80GZV37Qkpne0adgl+W56pZLwDrom1F0Ykye3jJ4SJT/r8epCCbVB0dNo8Zw4LrKoPSFcO3ssE25KmW1mjs+N+JChkLRZfmyvLB/vTFTDlYy21hL2F5+qnFQ8fcho2/bl6BWcSmy05Ablw26Sis+6T37TCCmKdDKAb8WIQ2fqNsY9jVTOt+6itX89lM3RF1zvgDJiaCUXEpfaEFtAepNzMYaW0Nq0FT1zTVybHuHh6577xuqtzgvngRU0oI3Pf0dB9hBM0R6UVoE5WEQj5S3hYfUz8Z5CVM/Ni51UdnN7HjSy+rr5wEziE9Y1vqHAzpMW9vzFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR783+xsxL/ZEw7sNi2Wkku3r10wNqRSxxBWpbYH+Qo=;
 b=oOmtlrpOPFG4iVfhcQywxZdUVd2DzZlX2+Z5vmcU5DDx7HH0/ga0vpa4UcmNd2Gz0d/8SgILhfJm8Lm3j9YKGTa4zyfFgm/Y06YlslQ3bPxEF7n4Er5i6WJXVB7BWlG9+0NZErEUpjTjgOPkv+eJWsvQKPvN4a3uiLZaxNng3As6Laa7/7yk9cp561iqxK90puoNTaVwH48ld/+wkkTKG7iVgQxxNPmdLppbTa7XQHoDgW2Yo88p/ryK8s4lFPfg6txw0z7t2gg3M+idiZZn8XqB0OvpU0cOwbrwTxIY3qtcYQHEORs9aLMgghPOSvH7GLAqUnljJ9yKH1MgCc3XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR04MB4839.eurprd04.prod.outlook.com (2603:10a6:20b:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 05:50:44 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 05:50:44 +0000
Subject: Re: [PATCH] ocfs2: ocfs2_downconvert_lock failure results in deadlock
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org
CC:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826061038.22295-1-ghe@suse.com>
 <b3f498eb-7de5-8a7f-0f52-01c1e2caa5d8@linux.alibaba.com>
 <7795ed72-8b77-14ea-cf18-78870e58f429@suse.com>
 <0a8db668-b6f4-4b33-086a-2b522b343cf1@linux.alibaba.com>
From:   Gang He <ghe@suse.com>
Message-ID: <f19462cc-b816-ac40-e86a-a1900611c371@suse.com>
Date:   Fri, 27 Aug 2021 13:50:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0a8db668-b6f4-4b33-086a-2b522b343cf1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Fri, 27 Aug 2021 05:50:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca525c7-2881-4afd-7e96-08d9691e9c42
X-MS-TrafficTypeDiagnostic: AM6PR04MB4839:
X-Microsoft-Antispam-PRVS: <AM6PR04MB483935C4813D8B6292D90B95CFC89@AM6PR04MB4839.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu/iMKM9EMNpr3TruvpQcY8+bglY8Egq31CAU5zIBK42M3O1V+0jXa7G8OAJ6s6ZoF0IbLwm74WZ2RA7pKykSZFXI8dmirMW4AzsA0WVN3QKIgsLETRLr6NEJAkGgEZ2mG08deARhv59v9/fOVHWUOEoHSayrfPqmAsbimK15uFHKSaCoyWR21L9t3EPI9hwKbrVEJGl5c3/SlLlqurtsOvxHs3q7S+bmcD0Qitm+iX3fkf09lVaVEmE6Ee9nzQZYxYweEz7e3IgWQoxZGnJcCpS5Rb681I3Bf+vgCGzCi6l+LwR/zx2EznqqvpIgD4LrZFTVDzkNvYKjxotlngA7jNtR8usTh42NJpK40JJ7WVVLHutokSi7SQirF5gAAsMsxq+fe7C67G+ZlxdRwwuULWt62CU23ziYoJz7pQPQavEn1X7Tebt2KonuVH5sOXs2bN/id7M5SZpthcseqfguDFqUeSbtntfFH/rZbnbHjvn/c6y1TsffBYrFCJr4GxPQs8oTMlI8GAiSOBPYLbWecq/BhAivJ7u0XqhizAJGU43K44WZ1DY8bvcx5UAK6otbwezOTg41xMRLYMihQO3umIM4R8+eJ/2fukcKB9p2DB92ICGWPMrt2Yp2lGrm3wSncfvTuxrj53RnaVwIR/42wvBsQQ3iPmEmdvxfJl1peQTkqHUd9NkEQdbqzDzrFzMQm7/Xp3eRk9FqRBTmr3GE/Wp8mFS7iUzo4Wz7rh75BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(4326008)(6486002)(6666004)(5660300002)(478600001)(8936002)(66476007)(31696002)(38100700002)(53546011)(2906002)(2616005)(55236004)(86362001)(8676002)(186003)(36756003)(66556008)(31686004)(956004)(316002)(26005)(66946007)(16576012)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kh4rMFHT3g090S62WUViEt0+/uTmgpiZ7OIzr8r99omsUup+IqT1DGyS2TsJ?=
 =?us-ascii?Q?pS9+LH3qPG9Ewb82fSxtdh2ac83jiK2Yi/r+e2yBAx9SJa2okMEe6gI6N8rt?=
 =?us-ascii?Q?VXSsQGUb64CyBwrf9nlAIpQCsIMUmQ/Xf9zKujcYpAJhvcf+0/WorZrurIo8?=
 =?us-ascii?Q?hdB+jkDoZhUAU+3Fg9IBcYdr9Efks1hGuRDYnVEYCkxpxPwOhtCGuEIzDBUI?=
 =?us-ascii?Q?FE5IP4p5PcHjrUvlVukRZ1Aqzx99/XuCDnNZVQ5yrM/hFiNcTqVNHCrDbvkp?=
 =?us-ascii?Q?Wny5sOZHf8EijGCtVci3zqfHzRVq69TtEsnjOqxB6u0ayWXgeXsR5ijax2Dn?=
 =?us-ascii?Q?MuwdtbsoBWyOFoUf+D7HElsshqOjBJob3WbesuVL4it0+vZ7eeozeKDf7vtR?=
 =?us-ascii?Q?NJO/yAFI491j6mm56bmhYX0x3jqpjN9mqYUt5wjRE11DD7g3NAdJAYq7CyXz?=
 =?us-ascii?Q?LG2esRZZR8+gflyAu5pjLCL4rVzijzgsFApraB1mO0thxiclnhdOqpDy9C7M?=
 =?us-ascii?Q?HXxYrs79SMULYu76p6jZVnNsUisLyuRydPiMmeUK7nfyG0+X8WKedYjR6WrV?=
 =?us-ascii?Q?GkHkEEDnhpqlhjc+BibOMbtoThizA4o1H5AGZCsvhtBg1LRsTv/WgtyPMl+h?=
 =?us-ascii?Q?KCoUuIdIuGNveYDgAkvKsC0lm7W7psTSlqK7OhjllqWh9Orne+s5g0f7/R+7?=
 =?us-ascii?Q?00THvNoH5TDbleCn3EI/PIYs0/2EigzblXlYP/6OEcjrusxCw3OljwiCIccH?=
 =?us-ascii?Q?OEdVNvBJnz6BnAoAybg0HiN7DJtYG5gkCELKtxCwRk1Nd4TaniKDvvfYbohL?=
 =?us-ascii?Q?MGm5VJY9xoHLWS+wX8rwGlWxeN52lx2x44TTT9miw0SHZkLw/NPAfclLz0/c?=
 =?us-ascii?Q?jTq/YY/MN/jR5G6sjTocZ5tBIrz0sEYj/IdlX7EdGSgzhc/pR2obPE341Us5?=
 =?us-ascii?Q?tZMqQhfW6/Phk6wKxdB2dhl7Uv04JUiAsMgA9dWy1RZZvegVVy2LlbdVpp6H?=
 =?us-ascii?Q?sCGcnKbzpvEbFWYxmDN34YtFntvlvPFHo3v+5n+2WjbPj0UOVVSRopCtcKJw?=
 =?us-ascii?Q?Bu7UiqMO+m/FepjZRXoDIk2FXpTtBn6c4HDVn+jQG0nMscw5VLrL6nRRp/cS?=
 =?us-ascii?Q?blF1iaoI1iic+/P4J349q7xNsWQErUsaQ0/iWvrvr2I0hJJOVJZsVxepb9cc?=
 =?us-ascii?Q?D1sVwBVuRXkzb41CzXELTcue4m+Ch6ojGfDYVIUJYIjAZ7DeBaH4fjCW0mkX?=
 =?us-ascii?Q?QC0tgXyDsntVVATobWpStCHsy86PjXWWicTIjKdxAOEVOS4r7+YvJIQpa9DQ?=
 =?us-ascii?Q?Mn1lTPjwha1U2aRaAdy0H02U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca525c7-2881-4afd-7e96-08d9691e9c42
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 05:50:44.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy2tIHIavO+jUUjI5mZ26k+/FdvcBJPi9zF3/Ea8sAJX2Pn3eBcRmItv0UJsfW7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/26 17:55, Joseph Qi wrote:
>=20
>=20
> On 8/26/21 4:45 PM, Gang He wrote:
>> Hi Joseph,
>>
>> On 2021/8/26 16:23, Joseph Qi wrote:
>>>
>>>
>>> On 8/26/21 2:10 PM, Gang He wrote:
>>>> Usually, ocfs2_downconvert_lock() function always downconverts
>>>> dlm lock to the expected level for satisfy dlm bast requests
>>>
>>> s/for/to
>>>
>>>> from the other nodes.
>>>> But there is a rare situation. When dlm lock conversion is being
>>>> canceled, ocfs2_downconvert_lock() function will return -EBUSY.
>>>> You need to be aware that ocfs2_cancel_convert() function is
>>>> asynchronous in fsdlm implementation.
>>>> If we does not requeue this lockres entry, ocfs2 downconvert
>>>> thread no longer handles this dlm lock bast request. Then, the
>>>> other nodes will not get the dlm lock again, the current node's
>>>> process will be blocked when acquire this dlm lock again.
>>>>
>>>> Signed-off-by: Gang He <ghe@suse.com>
>>>> ---
>>>>  =C2=A0 fs/ocfs2/dlmglue.c | 13 +++++++++----
>>>>  =C2=A0 1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>>>> index 48fd369c29a4..c454c218fbfe 100644
>>>> --- a/fs/ocfs2/dlmglue.c
>>>> +++ b/fs/ocfs2/dlmglue.c
>>>> @@ -3671,13 +3671,11 @@ static int ocfs2_downconvert_lock(struct ocfs2=
_super *osb,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OCFS2_LOCK_ID_MAX_LEN - 1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockres_clear_pending(lockres, generat=
ion, osb);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ocfs2_log_dlm_error("ocfs2=
_dlm_lock", ret, lockres);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D -EBUSY)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oc=
fs2_log_dlm_error("ocfs2_dlm_lock", ret, lockres);
>>>
>>> Do we have to treat EBUSY as a normal case?
>> Yes, this return code is expected when call dlm_lock() to convert a dlm =
lock to another level, but this dlm lock is being cancelled.
>> As I said in another mail, for fsdlm implementation,ocfs2_cancel_convert
>> will return immediately, but the related dlm lock will(is) be cancelled =
in background. For o2dlm implementation,ocfs2_cancel_convert will return af=
ter the dlm lock is cancelled and it's ast is invoked, that is why o2cb bas=
ed ocfs2 does not encounter -EBUSY return code in my test script, of course=
, this kind of implementation will block other lockres entries to be handle=
d for a little time in down-convert thread.
>=20
> Better to leave this log for later issue tracking.
> I'm worrying about if there are other cases here.
OK

>=20
>>
>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ocfs2_recover_=
from_dlm_error(lockres, 1);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto bail;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>> -bail:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>>  =C2=A0 @@ -3912,6 +3910,13 @@ static int ocfs2_unblock_lock(struct oc=
fs2_super *osb,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&lockres->l_loc=
k, flags);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ocfs2_downconvert_lock(osb, lo=
ckres, new_level, set_lvb,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen);
>>>> +=C2=A0=C2=A0=C2=A0 /* ocfs2_cancel_convert() is in progress, try agai=
n later */
>>>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EBUSY) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctl->requeue =3D 1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mlog(ML_BASTS, "lockres %s=
, ReQ: Downconvert busy\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 lockres->l_name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>
>>> Ditto. If EBUSY is not a normal case, I'd like just requeue it but not
>>> change it to normal return code.
>>> You know ML_BASTS is always switched off in production environment.
>> Since this case should be considered as a normal case, although it's rar=
e.
>> We should not print any error message to kernel journal, but if the user
>> turn on the BASTS trace, he should watch this trace for debugging.
>>
>=20
> Okay, since we leave an error message above, we can return normal to
> caller. And now caller only print a simple error which doesn't have
> much meaning.
>=20
> BTW, could we change it like:
>=20
> ret =3D ocfs2_downconvert_lock();
> if (ret =3D=3D -EBUSY) {
> 	mlog(ML_BASTS, ...);
> 	/* Describe the case why we have to requeue */
> 	goto requeue;
> }

According to the current code, it is easy to
goto leave label with set ctl->requeue =3D 1 for requeue;


Thanks
Gang

>=20
> ...
> requeue:
> 	ctl->requeue =3D 1;
> 	return 0;
>=20
>=20

