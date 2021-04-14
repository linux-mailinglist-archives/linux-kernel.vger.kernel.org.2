Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7435F933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351833AbhDNQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:47:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351866AbhDNQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:47:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EGjuxZ162015;
        Wed, 14 Apr 2021 16:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=blLGRX2hxNsKjBqfXS9v+Ylxq3XIMHT+b78l+rFJ/es=;
 b=W7yKXY3YuWhi8y6OEqXFlMMyvrhsxBEhTMAVPTSfQujgQrY9OBDr+gb7bw0DH3flj4pm
 Wtqa2lR8k/uUyTrFvQ8x1meeQYK08DkhDvQfKwIrG+SG0jePlej9MLkF6Y30lPtFa1aG
 yMWfzKcjloMIkolHfVB8oWtmVcmX0GOls8X08To9rP9koI+02z8RxmJ0mtjGhSG+fRam
 XrnFoQmPlLuCI9a1TRSY/+/YXyMRXiCTVx1nlYtILilkSsu9skQOQkShLTy/J7arXUCA
 2DxCTWFqfpiRWhAVKy6uwCn1ZAvHka8o2rFYkCzK4Xgk2f6z7E362e5IUMsFzyBSJdpk 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37u1hbk8ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 16:45:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EGjleo190752;
        Wed, 14 Apr 2021 16:45:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 37unx1k7pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 16:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlBpQfKPllYM4mst6JDq9buTNAf+9P7jhVHQtj0ZDDRdXIdLLw+lkcGAermnc0QZioJLiW4U3oCHKPQFfZkAaa9gr1gF/mQTccFnU2zGoPX65pIxX+8GWxRNjqZ8gQhq+/ZTcaCPkkhTf+/18CibK74UHHtDXJEF9Ee5Ue+zFsp2PVawNj6KGHX2rgUNA7/aUsim1EWRwfHZy2hpPjFpdMH6I7D2QTtTNqSKYppY2lwD8zD5w3eZtxhH1iF1J8TietlAAiIZ5bSlOyfMzfNsloNbZ3hTKcZClGyxP/FpDqosBbeDq+WXQuDuj77Fqeb3/Trx8IEXxsPT9r3CCmSAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blLGRX2hxNsKjBqfXS9v+Ylxq3XIMHT+b78l+rFJ/es=;
 b=ceCgvN/LnHGye9b49S/GrQYSugurpMH8nlR6Oe58nK58zvPv/4D2ImGR0GpzlG41Zv5iI50pB1Xtbko+FkSMwQ+E1glKcjijGdxba6ZidsC9f+5XwmMEl4b+46hrifYNng9lUhd6aVkOvpRQNtV7GLy5Dnnw+a+Rg+dTf7dWvH1SW4HqtYkQiiDoUOkx3RuoGiyNWzXOmhQ9d6VN8kqiwvGzG0f/EqE2KGzjI+gs2GcTMcTThYkyi35ohr95+npRzqdShO2fd3ZR6wHgfhEw03erWNvubQ7uoNTqhCFpvMaHLroIvh9OniB8/ZKp3xvsWcT82ig9UURz5FG2PRAJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blLGRX2hxNsKjBqfXS9v+Ylxq3XIMHT+b78l+rFJ/es=;
 b=N4ln1au8ARXr62afOpR6vxol7BwhP3OOKOhh1RVXd54V6OkwljD74zuUdS136uXsLVaRxRKtDT1ZfqER68RFJcP9uu7OnGez5i4TUZ9lkyWrOkxv5BYIYUepHkvMxsXRAIJTe5RQq4MlgZrfvOPW3w5QRlrzenduoynwMtQS1qA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5422.namprd10.prod.outlook.com (2603:10b6:a03:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 16:45:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 16:45:52 +0000
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de> <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz> <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz> <20210414100147.GD20886@linux>
 <YHbE2q/Otrdx1cgK@dhcp22.suse.cz> <20210414104953.GF20886@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b763adaf-258a-930f-d8f2-5d236e217fe7@oracle.com>
Date:   Wed, 14 Apr 2021 09:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210414104953.GF20886@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 16:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d43366-8d24-4a36-9e0c-08d8ff64c417
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5422:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB542254FA6B82AA8F6DEC3E44E24E9@SJ0PR10MB5422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oymFXZNh2IChCehupydy9wfh1Dl4oR+V56gtJMKj0ixEbBJDK+xsARtw4/woNl3SO+WCF6sMQuVucb/mdaBfo2mrJVB2EUtjaOofrAvUYvjkcJGXrfptL7xoHrfueL6Q86GBOnZye0V6a3JXJ3bekNs5l79DBgMmFErFnLs4PZ5ESKiIKAopQNNGFz1T0TIeBQteRqogs6vyhbxEW3WC0+F/8FF0edj1mFFEsQH96ItE6k48XUd0SgRC+IA5JkmSNP7x0nvheea0IfQntjS16epCqE+Mh8Ej+1iABPonY1bJLK/NIqxtAjUYjteRzZZ8XZVAQCFXwhtNnctGm08uxr8AighzySVvGlRSCG7MfVfoq/b/0EKFSdr6xcd6FmtAaY3jDiAHNTlEfdJKjX7pA57zwldzgaYKEoAz/3DBab/y5uknXVM3edH/BCOwJj78+vwYOjewiTVSzkSizklDJ82DcLvnvoLxWPOCGDpITFc82oNMOVl/5WjJW1eUUje3ohAD1qkitn7O10yzyuVkWARQ5oBUSFBTHQcPYYWpmsfpgUVRei3lMnx41ZN9CnCLcdcoB9y12JpMSEoGLgCgus9DwqfSIj4/v056HhUDKsJ3/xSJ9f3bTM7NHHa3R65P1gwpgHYwZXEmrcPXG9xeN7riu4by/Y9XyUu1ckihLtouYzZCs2kPTu/auoDQ3ulZ+wt8PsirINP8DUU90PloTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(136003)(376002)(54906003)(52116002)(8936002)(36756003)(86362001)(6486002)(66476007)(66556008)(66946007)(316002)(2906002)(38350700002)(110136005)(8676002)(16576012)(38100700002)(186003)(31686004)(478600001)(16526019)(5660300002)(53546011)(44832011)(6666004)(956004)(26005)(2616005)(4326008)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q9DQ4I/Wpr8EiuZPmTn3IiM3O+FIGvzd1uzy1SLVfMeCGZndQd8OPrFanBjJi3Si6MalnqN7y/hx8zJL3Sk76mpzByFqm0mZqdXQsg651XuBLpnRYAfdB84y7EWYQI1N1PLTlO9XopM5eHtuHZvGG8hBGgn1AzF7cFuQqLG8/5AiW+8U1hMYAAm/1nPsPUfLD+QQkWoNWDTqmFL9g/hgRXrmwfcwkfkUxG7AB5MtWbphpg3NJefQ1dNJCBaf2mk39TY9wM1AEQEPrEnJNwluRQDDK1Fr7NqJVtI+kvT29GDGAF3UEt0ZKs2YbQqCZCK59b5HIB59tMjcnoAdFxD+UlWSmW5uLaPBDSpgJEcnkbRBI29XYtr+j/kwzJn6Bd0jMM2FrjBzM7/kmiq/AzLCVon15ZHxZfsPe2TKU2vICFsdW+n7rDisxOIv01kQ2Yw9Xel1QMZBC+pUCWdkXI7LStiy9SFZ/pJWK/IhIhJ9tEnyxE7empn/tsEv/cuAW1rKKwgtSFnRWCJuJ9NI2WYRaaKoOWoRuze/Csxxg45qORvYxBpGc+/JS1BCuf4sgmnixOr1OiIYDTGwGZIDrT4qIj1tbrrdNjTKZie9uYE7kpHviuzEZBWhySjR3V6nfMb7RK8n8PFBZ06IVHwuZfgXo0hGpXeaVTMlNgDFiVXPj1canSVJ5cSPV848U5RzCuYv5cAOJnW95fkhdbV/iCD3Pjo+ozZKs8qyUrMetQhO7Ss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d43366-8d24-4a36-9e0c-08d8ff64c417
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 16:45:52.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39hzsF655G4LbRHUneLHoPPscN+GNepurF8UglASmmMW3Ug4U5krdsIoMoQH6fgtZHFwiJbU0QL0BbB40zs9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5422
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140108
X-Proofpoint-GUID: gsxvWCfxnstlXnPEobIGAw2CfeYTvMri
X-Proofpoint-ORIG-GUID: gsxvWCfxnstlXnPEobIGAw2CfeYTvMri
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 3:49 AM, Oscar Salvador wrote:
> On Wed, Apr 14, 2021 at 12:32:58PM +0200, Michal Hocko wrote:
>> Well, to be precise it does the very same thing with memamp struct pages
>> but that is before the initialization code you have pointed out above.
>> In this context it just poisons the allocated content which is the GB
>> page storage.
> 
> Right.
> 
>>> I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
>>> still zeroed, so I guess it should be safe to assume that we do not really need
>>> to clear the flag in __prep_new_huge_page() routine?
>>
>> It would be quite nasty if the struct pages content would be undefined.
>> Maybe that is possible but then I would rather stick the initialization
>> into __alloc_bootmem_huge_page.
> 
> Yes, but I do not think that is really possible unless I missed something.
> Let us see what Mike thinks of it, if there are no objections, we can
> get rid of the clearing flag right there.
>  

Thanks for crawling through that code Oscar!

I do not think you missed anything.  Let's just get rid of the flag
clearing.
-- 
Mike Kravetz
