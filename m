Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D642C385
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhJMOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:41:04 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:10028 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhJMOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1634135941;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b6xzbeBB2CrHvfzREIMn89uBqWGXdkNUi54NJeG039g=;
  b=aBsvFms3D3yLrutDJ1BPH3u80DLgmb+eVBmT08TyoPhNs/aOq74YDtQk
   diV0/0NOp/W86c4vQcOsr5LkTIzLBwfabVChma5VKkOPpjA0ySt+BiFZV
   1ZSCB+vKyMCrOjhGWVpdP2d/Vblq4/wwRefIrAsv7VUbiyX25EppnfQvT
   E=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: qyNj2L/HSFi7uF5SBcifw95H455FIALUH0CJLUk9ueenNGzv99E6Md/sT4wVfLBrlQcCGAFUie
 eojpYpmO08MhOu6tLP1JHr9x95Vp9Qgf4sa75ZH3QnTgImznjZ63bZqbJWPHY9wFx2oXXo8+cS
 lg+SurmGf5xnk3XlicgD1morWpYRZK03GwfvEFnqVDrRB/7bOh1TqabYvynytTZDzW0Y1zQAkX
 5WuDtkCXiemDIfSwVjs6aHpJIjPPik9gF6UOxV+SYUeVjp+2yN9q0284AdFF3e8QFAF0pnx4ON
 Gg2UDsBbNm6zv97yI/Dos/81
X-SBRS: 5.1
X-MesageID: 55499160
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:5g4CsqIx82/JU2omFE+RYJIlxSXFcZb7ZxGr2PjKsXjdYENS0T0Ay
 TdOXW+CMv6LNjT0fdF3OY7ioB5Tv5/VzYdgSVZlqX01Q3x08seUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokcxIn5BC5C5xZVG/fjgqoHUVaiUZ0ideSc+EH140Eo6wLZi6mJVqYPR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyB94KYkDbOwNxPFrrx8RYZWc
 QphIIaRpQs19z91Yj+sfy2SnkciGtY+NiDW4pZatjTLbrGvaUXe345iXMfwZ3u7hB22x/sp9
 fIO66foZlkxZa3Lk+NBahlhRnQW0a1uoNcrIFC6uM2XiUbHb2Ht07NlC0Re0Y8wo7gtRzsUr
 LpBdW5LPkvra+GemdpXTsFFgMg5IdatF4QYonx6lhnSDOo8QICFSKLPjTNd9Gpt2pEfRKiGD
 yYfQT9uTATiZAZ9AHY8M84OzNn5gSHQTCIN/Tp5ooJoujOOnWSdyoPFMsLSe9mAQsh9hEuUp
 mvauW/+B3kyJIzB4TmI6HShgqnIhyyTcJofCLCi5NZrhlOJz2AeARFQUkG0ydG/hkOlUs9bL
 U0Z4DEGoq81+0imCNL6WnWQqXqJrhMdHcFMGvc99gaM1q3KywmcD2kACDVGbbQOsM4wWCxv1
 VKTmd7tLSJgvafTSn+H8LqQ6zSoNkAowXQqPHFeC1Ffup+6/d913kmnostf/LCdsYXeQQzXg
 G6x9Adgn+4TisUMi5y7xAWS696znaThQgkw7wTRe2uq6AJleYKoD7CVBUjnAeVod9nBEAHQ1
 JQQs43HtrpWVMDS/MCYaLxVROnB2hqTDNHLbbeD9bEa/DOx52XrQ4lU5DxvTKuCGpdZIWG3C
 KM/VAU42XOyAJdIRfMpC25SI55zpUQFKTgDfquLBjapSsIgHDJrBAk0OSatM5nFySDAa50XN
 5aBatqLBn0HE6lhxzfeb75DiuNzmHxknTmPHsyTI/GbPVy2PyH9pVAtagrmUwzExPnc/FW9H
 yh3ZqNmNCmzoMWhO3KKoOb/3HgBLGQhBICeliCkXrXrH+aSI0l4U6W56ep4I+RNxv0J/s+Vr
 iDVchIJkzLX2CyYQThmn1g+MdsDq74k9illVcHtVH71s0UejXGHtf9FKcRsJ+V7rYSOD5dcF
 pE4RilJOdwWIhzv8DUBd5jt6otkcRWgnwWVOCS5JjM4evZdq8bhobcIpyPjq3sDCDSZr8w7r
 +Hy3w/XW8NbFQ9jENzXeLSkyFbo5SoRn+d7Xk3pJNhPeRqzrNg2enKp1vJncdsRLRjjxyeB0
 1rECxkvuuSQ8ZQ+98PEhP7Yot7xQfd+BEdTA0LS8a2yaXvB5mOmzIIZCLSIcDnRWXna4qKnY
 ekJnfjwPOdexARBspZmEqYtxqU7voO9q7hfxwViPXPKc1X0Ve8wfijYhZFC7/QfyKVYtA26X
 lO01uNbYbjZatn4FFMxJRY+arjR3/8jhTSPv+8+J1/35XEr8ePfA1lSJRSFlAdUMKBxbNE+2
 e4ktcMbt16/hx4tPorUhyxY7T3RfHkJUqFhvZAGGo77zAEszwgaM5DbDyb35rCJaslNbRZ2c
 mPF2vKaiuQO3FfGfloyCWPJjLhUipk5sRxXyEMPegaSkd3fi/5rhBBc/FzblOiOIsmrBw6rB
 lVWCg==
IronPort-HdrOrdr: A9a23:Ld4xoa9pkTv7wIFj64xuk+FKdb1zdoMgy1knxilNoENuHPBwxv
 rAoB1E73PJYVYqOE3Jmbi7Sc29qADnhOBICO4qTMiftWjdyReVxeRZjLcKrAeQYBEWmtQts5
 uINpIOdeEYbmIK/voSgjPIa+rIqePvmMvD6Ja8vhUdPz2CKZsQiDuRYjzrYnGeLzM2fKbReq
 Dsg/av6wDQA0j+Oa+Adwg4tqX41pH2vaOjRSRDKw8s6QGIgz/twLnmEyKA1hNbdz9U278t/U
 XMjgS8v8yYwr+G4y6Z81WWw4VdmdPnxNcGLMuQivINIjGprgqzfoxuV5CLoThwiuCy71QBls
 XKvn4bTotOwkKUWlvwjQrm2gHm3jprw3j+yWWAiX+mmsD9TCJSMbsLuatpNj/ir2YwttB116
 xGm0iDsYBMMB/GlCPho/DVShBDjCOP0DkfuN9Wq0YafZoVabdXo4Ba1lhSCo08ECXz751iOP
 VyDfvb+O1dfTqhHjDkV1FUsZmRt0kIb1O7qhBogL3T79EWpgE586Ig/r1cop9an6hNDaWt5I
 z/Q+xVff91P5YrhJlGdZM8qP2MeyXwqCL3QRevyGvcZdY60lL22tTKCeYOlayXkKJh9upFpH
 2GaiIBiVIP
X-IronPort-AV: E=Sophos;i="5.85,371,1624334400"; 
   d="scan'208";a="55499160"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIYIeeLDdEPC/S3h4w2XRCLvLLNVqJ7sQfU6gRZ8g1IbwNIYWVTHYCRKEpuw+wMW6vpVJh+GmD5ZNM40pwOEjhrP8OyjxB5MLmru8TvD0zHRT3Y1pXaqjXYbQf4i/+F4pNfwLYL+FYpOUxoYY2L5l7+HAUa5B2Bp8mv/sNrRwn4ECUM6WBA79/yTlVsrs79sAlXAZP3HKkgY9gWJ3/S0YDdo6MU5f84OlRbffklfijAWeCVE967iBgkrSzTZTK1KBnZ8xx5UGXtpSGgjUntw80bGJZlQdheboVHGUttbcVsnw4zwtWkzWObN2khiU8AB8SCuGBv/TyTezgE7ZAaFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luc97DM+PgUqTD3hx9rQwfens8LVAwe4d1GQA6+mFDY=;
 b=K/ICPLY1UvaQsmGlWbBMn95DoHCsbO1oO1J4HrKDUbPMKNA4rTh87dnW9Z6kaQA18pYTfTpBE7xapqs+pcXTMTI4gertZXPjClqbN0ubKOY/XbLH1Up02wsnjXYsDGRZSCD3a9w36SwT6tjBw7Dy0FYg6zZ/EF9EF979j4QnuojvfUvKaT+EZ7Nd0p0/ySPQcXgGt6sHzoFSj2Iz5st3VSyKvcBr05F2eqNFiCcIH21ozCyEwwANqCV5k7Z9IcFfd8TU2m5EJikkKo/BFv4mNLhqr6kzQq5gkT6xAuBO1/TTavg7kmcAt68uUfxBUUDuNYtx3XAKzNG3ivA4FrRIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luc97DM+PgUqTD3hx9rQwfens8LVAwe4d1GQA6+mFDY=;
 b=eu0dB6W43gxPQpM24+dOnb95yylsVBOCzDKtNr5MMdQ2N8w5PTK4G1YIRGPjlatV6Ne5Rtk1NfuTtTH5YdmYaYSWsgsgRHyDHoo6+UXCI6I4p4HR+7ccBhQq5D/VTZTwe4G3rrv0bWjjsDAazQ110E5fgfZfoaFfK13YjAMkNRE=
To:     Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
        <ndesaulniers@google.com>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <98fdd068-d1c3-1f8c-18b7-13c3909ed9ca@citrix.com>
Date:   Wed, 13 Oct 2021 15:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013123645.002402102@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::16) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faa2bfd-3490-4210-3e9d-08d98e572273
X-MS-TrafficTypeDiagnostic: BYAPR03MB4742:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4742AB8CEDBE513DFBF8AC4CBAB79@BYAPR03MB4742.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWYNx5hmstp8m33G507G455FnI+dVHgF0o3hLTNu4KWJPTiaUQCYaW1GSb0wr/MIUmVXVNUPjctE3NpG52GwhDQ7OU3kYV43Txf/eqcqL4CFv1S8FE3yA/e56yOW98fQblZgKiwo17Z186WhFhMoHUFIBGsejoU6/07ubEc5SvAyMT2/MMHscpx3m2AYUuGtX2IkYltrHk9T2cuRLqppQWWllAOkhVJ3dEPcriizKLYbd7zS/Y8MMtRhDOFWm5/CtTf2LhtU3U3jk+SDlR3z2Z1kYWoe0TmW2H4wERTmuvuVg9Q5gCp+fF+AJCxP4kPohRQorWLZS9cgAtEjjCbEazUbHJZduZ2s6CtAFluG1vZXUR3c03Tin6ltTa2aSvWuPA+R1+t6O1nZp4fnBHop72Sd/NBOTQDDbItrlA6MNllwO0EbJwIgfyw8nIiW00gJt5LTKCiL6uwwGSTc2C7D0gA8Yvj5Wb2IN6V1ynLjsH8AFfAtmTqi/mHorsogYejtJ56B0Bl+nLcEdDoqwLm3m/AW26PmzA3XRe/f65tqH7mQYJWyKFpyPxiwz9uhVqR5Gq+qSY6Sx5odwR276qS2HOqQeNsCYxDPGTxWYt1Le1NMg2vL21Fu99CnsI4cF79huG1V7J+90u7fxFYjalbhK1HYHqgoIQtV+heGNgSiJvWHPzP0iXyyLKvCrrt3RhL2kkRa7dJPARdGubx5KFe0MD4Fd7kzRXt0HWKg8Lvu9fuhqtTlhJacZWMgyMtKAABK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(956004)(4326008)(66556008)(66946007)(186003)(66476007)(8676002)(6486002)(82960400001)(86362001)(5660300002)(2616005)(83380400001)(26005)(6666004)(36756003)(31686004)(16576012)(31696002)(508600001)(38100700002)(53546011)(8936002)(316002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2t5UlVxL0JPVmVvNFNOOVI4Qk54SXQ5YmxqbGI5cDZZaHVZWER2TjREdFFI?=
 =?utf-8?B?aDhKQVR6SUp3TUdRUzE1MTBXREsrMEhidGRjTVdqKzJNS016WnAzZ0hUYmNQ?=
 =?utf-8?B?cnBER2thTWJ3b0hYZVhscndDL2s3aVZvcUpnbHNSK1hxRVROSHRmdXpmN3JX?=
 =?utf-8?B?UmZXMkJXdWRmMVdzMGs5ZkFHeDZqRlNQZFdvSU1Mb095Zm9mUVZheXZ2WC8r?=
 =?utf-8?B?eEpQY3pGTlBOd2p3TmUxRkFJd1ltLzhsUUxHWGtmU0VPM2FnSUh3VGJGbDFI?=
 =?utf-8?B?VXl1Q21xcm1uM0NkZTV0RmV5YzEvUVZ3ak9naGtIc2pld3l0bGs5SlVWaWZ6?=
 =?utf-8?B?OFIxRjlLb0t2VWlWZUloMFJlNTZGeGdnVG9tZitESjhiR1BnSHZKdmVtdTRG?=
 =?utf-8?B?UGFMTk5zMVRYSlAyb3ZQbWwvMUQ4dE5pTWNrTklJd1kvSXVzYWttaUFEMkFh?=
 =?utf-8?B?cDV3L3ZpNWtwTk5HQ0ZYV3pmVmhFTmkrMTJaUiswVFVPbVl5Q3RzSFlENERO?=
 =?utf-8?B?d2gvMW9DRmkxQ0JaM1ZRaFdhL29BVXZNQSsybDFIWFQrL0JHcjR2ZnRwWE1q?=
 =?utf-8?B?QUg0L0lCTmZVZzN3RUR0THNacDF1OXJoSFYvQWhuSHlDMmRiVkVtaU9NQ1FR?=
 =?utf-8?B?WWhOcnlzVHJsVW9xYkdvNGM5QlVGRThrNEs5eFgzRmVtSnpUeTBnaWY0TFdI?=
 =?utf-8?B?N2hjM0UxUFJueUhQTFN6SnNzMDN1ZWNSRW92ZkNRcmxVNWVnQ2JkdW5mVUF2?=
 =?utf-8?B?Ri8wZlBuamlGK1o0YWRYZnY4WTU2Vmd0SDc1VmJEZ0FFbHNEVXdaR1BSekJ0?=
 =?utf-8?B?ODdqM0txT0xZUWx6MWNVRE13MzBWeE5ZV2xCb0dJNmFmUjdlRXF6ajEvZ3RN?=
 =?utf-8?B?QnBjSTNqSU1DUWdpQ2N5cFFkZUw4KytyN05GK2JKMjRPZk5la1lyTGNKenFw?=
 =?utf-8?B?dWVYemhHbUtHOGY5amtUZFQ3cTAyZ0NKZWxkTFNvczVTcG1sU3dvblY2SHJ0?=
 =?utf-8?B?dHRjRTJEalFlYXJyWXdCL2x2YzBCY1A0TnNjY0VmMzhDQWE2S1NPNFFaRFZM?=
 =?utf-8?B?dmMzNm5pYWFlc0tZc1dRR2w3VFUzd3NtZUdMSmZqTlBZYkp0V1dNQkYrVmQ5?=
 =?utf-8?B?eTJWR2ZwM04xSllQUjlwTG8xWFJPZUtjZHVvRDFETmFHZkNocmwxSzg2K2J0?=
 =?utf-8?B?QkxxWmhXS3JNSU9uR2xHOVhzbGl6QkN4bmdld2x3Y2l4VFpUaXpNMW1hQ2R1?=
 =?utf-8?B?RTY0OHRnM0ZwZEJBclJQZmJQeUNMS0liUmNMZVpTcFZOc1E5SCs1K1gvNkJw?=
 =?utf-8?B?K2tMMUplSUNaODJjZm9KZmg2bzJxd0h0S1VaSGRrc0ZlY0cvd012eTE3WFd1?=
 =?utf-8?B?WlVSVVRlOFVmbWpteDZ4QVNxWms5UmxVZWFBQ28vVXVlMzhzdUhJVHY2Y1hC?=
 =?utf-8?B?UE5tSWpMZmppTmlCQTFsRVBiQ0p1MnlQM2QwWGpHQVpCM3VkQUkrZW9zeVpr?=
 =?utf-8?B?bjhsNHZQSmdsS0dIZ0c3blBtdlpBZnlqdGQ3blFnV1ZpTFpOMEx6VHVDdVpB?=
 =?utf-8?B?S0JvUEpWWW5kNUlrTEdPRWNXM090a3VTY2tJRjdHMjdCY3FoeXZncUVialNq?=
 =?utf-8?B?aDA5Y0FFWjU4VVhTRkgvYk1WaWF4Qm9LdkNYa2VTMGlKUm52UU94dUUxYkVQ?=
 =?utf-8?B?N053eHZxWTF4Wk9ha25kQmRlek5pK3RzaXNOdHdydkl1RngxY1I5ODZSUDRE?=
 =?utf-8?Q?3SI5NCPW3vwcpq4qXbHVTt5tWcdnF73LQ/AiSID?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faa2bfd-3490-4210-3e9d-08d98e572273
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:38:34.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXEiQGwctTMK5z6pbHMLVcxemJEMOKxc02b100tTEBs8iCU8azarUKDqo25WoONshxk1QYZlVZn1MjmlNHD14igi/CpUfzN8wGkBucyH39w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4742
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2021 13:22, Peter Zijlstra wrote:
> +/*
> + * Rewrite the compiler generated retpoline thunk calls.
> + *
> + * For spectre_v2=3Doff (!X86_FEATURE_RETPOLINE), rewrite them into imme=
diate
> + * indirect instructions, avoiding the extra indirection.
> + *
> + * For example, convert:
> + *
> + *   CALL __x86_indirect_thunk_\reg
> + *
> + * into:
> + *
> + *   CALL *%\reg
> + *
> + */
> +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> +{
> +	void (*target)(void);
> +	int reg, i =3D 0;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +		return -1;
> +
> +	target =3D addr + insn->length + insn->immediate.value;
> +	reg =3D (target - &__x86_indirect_thunk_rax) /
> +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);

This is equal measures beautiful and terrifying.

Something around here really wants to BUG_ON(reg =3D=3D 4), because
literally nothing good can come from selecting %rsp.

Also, it might be a good idea (previous patch perhaps) to have some
linker assertions to confirm that the symbols are laid out safely to do
this calculation.

~Andrew

